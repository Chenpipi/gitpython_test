local path="/usr/local/nginx/lua_v2/config.properties"
local request_method = ngx.var.request_method
local args = nil
local logString = nil
local logType = nil
local configTable ={}
local logName=nil
local date=os.date("%Y-%m-%d %H:%M:%S");

--log seperator
local seperator="|"

string.split = function(s, p)
        local ret = {}
        string.gsub(s, '[^'..p..']+', function(w) table.insert(ret, w) end)
        return ret
end

local logging = function(logPath,logString)
		local f,err = io.open(logPath, "a")
		if not f then
			ngx.log(ngx.ERR,err)
			ngx.log(ngx.ERR, logPath.." not exist")
			return nil, string.format("file `%s' could not be opened for writing", logPath)
		end
		f:setvbuf ("line")
		f:write(logString)
		f:write("\r\n")
		return "OK"
end


local file = io.open(path,"r"); 
if file~=nil then 
	for line in file:lines() do
		 pairs=string.split(line,"=")
        local key = pairs[1]
        if(key~=nil) then
		     configTable[key]=pairs[2]
       end 
	end
	file:close()
else
   ngx.say("config file does not exist!!")
end

if "GET" == request_method then
    args = ngx.req.get_uri_args()
elseif "POST" == request_method then
     ngx.req.read_body()
    args = ngx.req.get_post_args()
end


--deal with log------------------------------------------------------------
local logDir=configTable["tmlogDir"];
version=configTable["version"];
host=configTable["host"];
businessField=configTable["businessField"];
logString = args["log"]
if(logString~=nil) then
logLines=string.split(logString,seperator)

if(logLines~=nil) then
   logType =logLines[2]
   logName=configTable[logType]
   if(logName~=nil) then
   logFile=logDir..logName
   logString=version..seperator..host..seperator.."OTT_"..logName..seperator..businessField..seperator..date..seperator..logString
   logging(logFile,logString)
  else
    ngx.say("logType  does not exist!!")
end 
end
end

ngx.say("ok")
