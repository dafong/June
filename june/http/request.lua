local req = ngx.req

local M={}

function M:new()
    local headers = req.get_headers()
    req.read_body()
    local body = {}
    local args = req.get_post_args()
    if args and type(args) == "table" then
        for k,v in pairs(args) do
            body[k] = v
        end
    end

    local ins = {
        origin_uri = ngx.var.request_uri,
        path   = ngx.var.uri,
        method = req.get_method(),
        query  = req.get_uri_args(),
        body   = body,
        req_args = ngx.var.args,
        filters = nil,
        handler = nil,
        handler_func = nil
    }
    setmetatable(ins,{ __index = self })
    return ins
end


return M
