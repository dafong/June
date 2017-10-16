local req = ngx.req

local M = {}

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
        __modules = {},
        origin_uri = ngx.var.request_uri,
        path   = ngx.var.uri,
        method = req.get_method(),
        query  = req.get_uri_args(),
        body   = body,
        req_args = ngx.var.args
    }

    setmetatable(ins,{
        __index = function(t,k)
            if self[k] then t[k] = self[k]; return self[k] end
            if t.__modules[k] then return t.__modules[k] end
        end,
        __newindex = function(t,k,v)
            if t.__modules[k] ~= nil then
                error("error when override module: ".. k)
            end
            rawset(t,k,v)
        end})
    return ins
end

function M:reg_module(name,mod)
    if self.__modules[name] then error("same module with name "..name.." exist") end
    self.__modules[name]=mod
end

function M:unreg_module(name,mod)
    self.__modules[name] = nil
end

return M
