local june = require"june.june"
local conf = require"config"
local http = june:create_http(conf)
http:run()
-- ngx.say("hello i am index.lua")
-- ngx.say("ngx.var.uri = " ..ngx.var.uri )
-- ngx.say("ngx.req.get_method() = " ..  ngx.req.get_method())
-- ngx.say("ngx.var.request_uri = ".. ngx.var.request_uri )
-- ngx.say("ngx.var.request_filename = "..ngx.var.request_filename)
