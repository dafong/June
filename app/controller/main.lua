local M = {}
local http = require"http"
local json = require"cjson"

function M.dashboard()
	local resp = http:get("/system/info",{a=1})
	ngx.say(resp.data.game)
	-- ngx.thread.spawn(function()
	-- 	print("wid="..wid)
	-- 	local httpc  = http.new()
	-- 	local res,err = httpc:request_uri("http://192.168.8.183/system/info",{
	-- 		method = "GET"
	-- 	})
	-- 	if not res then
	--         print("failed to request: ", err)
	-- 	else
	-- 		print(res.body)
	--     end
	-- end)
	-- print("request end")
	ngx.say("i am dashboard")
end

return M
