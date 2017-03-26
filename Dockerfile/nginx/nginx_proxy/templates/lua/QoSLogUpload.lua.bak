local path="/usr/local/nginx/lua/config.properties"
local request_method = ngx.var.request_method
local args = nil
local logString = nil
local logType = nil
local configTable ={}


string.split = function(s, p)
        local ret = {}
        string.gsub(s, '[^'..p..']+', function(w) table.insert(ret, w) end)
        return ret
end

if "POST" == request_method then
    ngx.req.read_body()
    args = ngx.req.get_post_args()
elseif "GET" == request_method then
    args = ngx.req.get_uri_args()
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

logString = args["QoSData"]

logType = args["LogType"]

logName=configTable[logType]
local logDir=configTable["tmlogDir"];
version=configTable["version"];
host=configTable["host"];
businessField=configTable["businessField"];
logFile=logDir..logName


local seperator="|"

local lineSeperator="\r"

--date format
local logPattern="%message|%date\n"

--time format
local datePattern="%Y%m%d%H%M%S"

local prepareLogMsg=function(pattern,dt,message)
	  local logMsg = pattern
    message = string.gsub(message, "%%", "%%%%")
    logMsg = string.gsub(logMsg, "%%date", dt)
    logMsg = string.gsub(logMsg, "%%message", message)
    return logMsg
end

local logging = function(logPath,lineSeperator,logString)
		local f,err = io.open(logPath, "a")
		if not f then
			ngx.log(ngx.ERR,err)
			ngx.log(ngx.ERR, logPath.." not exist")
			return nil, string.format("file `%s' could not be opened for writing", logPath)
		end
		f:setvbuf ("line")
		logLineS=string.split(logString,lineSeperator)
		if(logLineS~=nil) then
			for m=1, #(logLineS) do
			  log=version..seperator..host..seperator..logName..seperator..businessField..seperator..logLineS[m]
			  f:write(log)
		    f:write("\r\n")
			end
		end
		return "OK"

end

ngx.say("logType="..logType)

--log deal---------------------------
if(logString~=nil) then
   logging(logFile,lineSeperator,logString)
end 

ngx.say("ok")
