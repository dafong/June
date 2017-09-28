local M = {}
local http = require"http"
local json = require"cjson"
local util = require"utils"

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
	ngx.say("i am dashboard<br>")
	ngx.say(ngx.var.uri .. "<br>")
	ngx.say(ngx.req.get_method().. "<br>")
	ngx.say(ngx.var.request_uri.. "<br>")
	ngx.say(ngx.var.args.."<br>")
	ngx.log(ngx.ERR,util:tableToString(ngx.req.get_uri_args()))
	ngx.say(ngx.var.realpath_root.."<br>")

end

return M
