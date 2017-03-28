local requestUri = ngx.var.request_uri
local request_method = ngx.var.request_method
local args = nil
local param = nil
local param2 = nil
local urlParam=""
local redisKey=nil
local requestPath=ngx.var.uri
local method = nil
local getRequestArgs=nil
local expireTime=3600
local timeout=1000
local cacheServerIP='memcached'
local cacheServerPort='11211'

local logPath="/var/log/nginx/epg_cache.log"
local paramFilter="/usr/local/nginx/lua/lua.properties"


local socket = require "socket"
local bTime=socket.gettime();
local eTime= nil


local clientIP = ngx.req.get_headers()["X-Real-IP"]

if clientIP == nil then
	clientIP = ngx.req.get_headers()["x_forwarded_for"]
        if type(clientIP) == "table" then
            clientIP = clientIP[1]
        end
end
if clientIP == nil then
	clientIP = ngx.var.remote_addr
end

require "logging.file"
local logger = logging.file(logPath, "%Y-%m-%d")

string.split = function(s, p)
        local ret = {}
        string.gsub(s, '[^'..p..']+', function(w) table.insert(ret, w) end)
        return ret
end

--1.获取请求参数
if "GET" == request_method then
	method=ngx.HTTP_GET
    args = ngx.req.get_uri_args()
elseif "POST" == request_method then
	method=ngx.HTTP_POST
    ngx.req.read_body()
    args = ngx.req.get_post_args()
	getRequestArgs = ngx.req.get_uri_args()
end

--ngx.say("requestUri=",requestUri)
--ngx.say("requestPath=",ngx.var.uri)
--ngx.say("arg_PARAMETER=",ngx.var.args)

--[[
for key,val in pairs(ngx.var.args) do
	ngx.say(key.."==",val)
end
]]--

--local partRequestPath = string.sub(requestPath,2,string.len(requestPath))  
local forwardUrl="/lua"..requestPath
--ngx.say("forwardUrl=",forwardUrl)
--local redis = require "resty.redis"
--local cache = redis.new()
local memcached = require "resty.memcached"
local cache = memcached : new()

local ok, err = cache:connect(cacheServerIP, cacheServerPort)
cache:set_timeout(timeout)


if not ok then
    --ngx.say("failed to connect:", err)
	logger:error("failed to connect memcached"..err)
	--ngx.log(ngx.ERR, err);
		
	local proxy = ngx.location.capture(forwardUrl, {
                method,args= args
                })

	page = proxy.body
	--ngx.say(page)
	
	return
else
	--ngx.say("connect to redis sucess")
end





--ngx.say("method=",method)


--ngx.say("parm start ----------------------")
--[[
if(args~=nil) then
	for key,val in pairs(args) do
		ngx.say(key.."=",val)
	end
end


if(getRequestArgs~=nil) then
	for key,val in pairs(getRequestArgs) do
		ngx.say(key.."=",val)
	end
end

ngx.say("parm end ----------------------")
]]--



--获取客户端请求的所有参数
local keySort = {}
if(getRequestArgs~=nil) then
	for key,_ in pairs(getRequestArgs) do
		table.insert(keySort,key)
	end
end

if(args~=nil) then
	for key,_ in pairs(args) do
		table.insert(keySort,key)
	end
end	
--[[
for m=1, #(keySort) do
	ngx.say("keySort["..m.."]=",keySort[m])
end
]]--
--根据配置文件，过滤客户端请求的参数
local filterKeys = nil
local file = io.open(paramFilter,"r"); 
if file~=nil then 
	for line in file:lines() do
		local endIndex=string.find(line,"=")
		local partten=string.sub(line,1,endIndex-1)
		--print("partten="..partten)
		
		if(partten==requestPath) then
			local keyStr=string.sub(line,endIndex+1,string.len(line))	
			filterKeys=string.split(keyStr,",")
		end
		--ngx.say("file content=",l)
	end
	file:close()
else
	--ngx.say("file does not exist!!")
end

if(filterKeys~=nil) then
	for m=1, #(filterKeys) do
		local index=nil
		for n=1, #(keySort) do
			if(filterKeys[m]==keySort[n]) then
				index=n
				--ngx.say("index=",index)
				break
			end
		end
		if(index~=nil) then
			--ngx.say("keySort=",keySort[index])
			--ngx.say("remote key=",keySort[index])
			table.remove(keySort,index)
		end
	end
end


--参数不为空的时候，对参数进行排序
if(table.getn(keySort)>0) then
	table.sort(keySort)

	local arraySize=table.getn(keySort)
	for i=1,arraySize do
		if(i+1<=arraySize) then
			if(args~=nil and args[keySort[i]]~=nil) then
				urlParam = urlParam..keySort[i].."=" .. args[keySort[i]].."&" 
			else
				if(getRequestArgs~=nil and getRequestArgs[keySort[i]]~=nil) then
					urlParam = urlParam..keySort[i].."=" .. getRequestArgs[keySort[i]].."&" 
				end
			end
		else
			if(args~=nil and args[keySort[i]]~=nil) then
				urlParam = urlParam..keySort[i].."=" .. args[keySort[i]] 
			else
				if(getRequestArgs~=nil and getRequestArgs[keySort[i]]~=nil) then
					urlParam = urlParam..keySort[i].."=" .. getRequestArgs[keySort[i]] 
				end
			end
		end
	end

	--ngx.say("urlParam=",urlParam)
end

--3.拼接KEY
local endIndex=string.find(requestUri,"?")
--3.1没？
if(endIndex==nil) then
	--3.11有参数
	if(table.getn(keySort)>0) then
		--ngx.say("没？，有参数")
		redisKey=requestUri.."?"..urlParam
	else
	--3.12没有参数
		--ngx.say("没？，没有参数")
		redisKey=requestUri
	end
else
--3.2有？
	--3.21有参数
	if(table.getn(keySort)>0) then
		--ngx.say("有？，有参数")
		local urlHead=string.sub(requestUri,1,endIndex)
		redisKey=urlHead..urlParam
	else
	--3.22没有参数
		--ngx.say("有？，没有参数")
		redisKey=requestUri
	end
end

--ngx.say("redisKey=",redisKey)


require 'md5'
--local redisKeyCache=md5.sumhexa(redisKey) 
local redisKeyCache=ngx.md5(redisKey)

local page,flag, err = cache:get(redisKeyCache)

if page == nil then
	--ngx.say("redis does not match key="..redisKey)
	--local forwardUrl="/lua"
	local proxy = ngx.location.capture(forwardUrl, {
                method,args= args
                })
						--ngx.say("proxy.status : "..proxy.status)

	if proxy.status == 200 then
				--ngx.say("value1 : ")

			--判定json中RC属性是否大于0，如果大于0，就保存Cache中
			local cjson_safe = require "cjson.safe"
			vjson = cjson_safe.decode(proxy.body)
			if vjson ~= nil then 
				if vjson['Response']['Header']['RC'] >=0 then
					--ngx.say("forward to "..forwardUrl.." success")
					res, err = cache:set(redisKeyCache, proxy.body,expireTime)
					--cache:expire(redisKey, expireTime)
					if not res then
						logger:error("failed to set key="..redisKey.." "..err)
						--ngx.say("failed to set : "..redisKey, err)
					end
				end
			end
	else
		logger:error("forward to "..forwardUrl.." error")
		--ngx.say("forward to "..forwardUrl.." error")
	end
	
	page = proxy.body
	eTime = socket.gettime()
        --logger:info((eTime-bTime).." "..clientIP.." missed key="..redisKey)
        logger:info(clientIP.." missed key="..redisKey)
else
	--ngx.say("redis match key="..redisKey)
	eTime = socket.gettime()
	--logger:info((eTime-bTime).." "..clientIP.." hitted key="..redisKey)
	logger:info(clientIP.." hitted key="..redisKey)
end

ngx.say(page)

local ok, err = cache:close()
if not ok then
	logger:error("failed to close memcached"..err)
  --ngx.say("failed to close:", err)
  --ngx.log(ngx.ERR, err);
  return
end
