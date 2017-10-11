local M = {}
local http = require"http"
local util = require"utils"

function M:plantext(req,resp)

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
		id  = 666,
		name= "fxl"
	})
end



return M
