local re=ngx.re
local unescape_uri = ngx.unescape_uri
local M={}

function M.run()
	-- ngx.say(ngx.var.uri)
	-- local query =  ngx.unescape_uri(ngx.var.arg_query)
	local query = unescape_uri(ngx.var.query_string)
	ngx.log(ngx.INFO,"query="..query)
	local params = {}
	local match_table = {}
	local regex = "q=([^&]*)"
	local m = re.match(query,regex,"",match_table)
	if m then
		ngx.log(ngx.INFO,"m2="..m[1])
		m = re.match(m[1],"/(.+)/(.+)?")
		if not m then
			return ngx.exit(404)
		end
		print(string.format("controller=%s function=%s",m[1],m[2]))
		local status,err = pcall(function()
			require("controller."..m[1])[m[2]]()
		end)
		if not status then
			ngx.log(ngx.ERR,err)
			return ngx.exit(500)
		end
	else
		return require("controller.main").dashboard()
	end

end

return M
