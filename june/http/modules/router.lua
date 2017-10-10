local M={}
local utils = require"utils"
function M:process(req,resp)
    local path = ngx.re.sub(req.origin_uri, "^/+", "")
    local pathinfo = path:split("/")
    local ok,e,func = pcall(function()
        local c = require("controller."..pathinfo[1])
        if type(c[pathinfo[2]]) ~= "function" then
            error("not a function")
        end
        return c,c[pathinfo[2]]
    end)

    if ok then
        req.handler = e
        req.handler_func = func
    else
        ngx.log(ngx.ERR,e)
    end
end

setmetatable( M , { __call = function(conf)
    local ins = {}
    setmetatable(ins,{ __index = M })
    return ins
end})

return M
