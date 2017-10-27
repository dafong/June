local M = {}

local util = require"utils"
local db = require"june.utils.mysql"
local redis = require"june.utils.redis"
local json = require"cjson"

function M:redis(req,resp)
	ngx.say(redis:get("name"))
end

function M:mysql(req,resp)
	local row = db:query("select * from test.user")
	ngx.say(json.encode(row))
	row = db:query("update test.user set name='asd' where id = 1 ")
	ngx.say(json.encode(row))
end


function M:dashboard(req,resp)
	-- ngx.log(ngx.ERR,"dashboard")
	-- ngx.say("i am dashboard<br>")
	-- ngx.say(ngx.var.uri .. "<br>")
	-- ngx.say(ngx.req.get_method().. "<br>")
	-- ngx.say(ngx.var.request_uri.. "<br>")
	-- ngx.say(ngx.var.args.."<br>")
	-- ngx.log(ngx.ERR,util:tableToString(ngx.req.get_uri_args()))

	resp:render("main/index.html",{
		wl  = "hi",
		name= "fxl"
	})
end



return M
