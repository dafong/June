local function main()
    require"june.log":override_ngx_log()
    -- require"june.log".rolling = true
    local june = require"june.june"
    local conf = require"config"
    local http = june:create_http(conf)
    http:run()
end
xpcall(main,function(error)
    pcall(function()
        local log  = require"june.log"
        log:error("error occured ! request uri:"..ngx.var.request_uri.."\n trace: "..error)
    end)
    ngx.status = 500
    ngx.say("server 500 error occured,trace:"..error)
end)
