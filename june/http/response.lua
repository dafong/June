local json = require"cjson"
local tmpl = require"resty.template"

local modules = {}

local M = {}

function M:new()
    local ins = {__modules={}}
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

function M:set_header(k,v)
    ngx.header[k] = v
end

function M:get_header(k)
    return ngx.header[k]
end

function M:status(status)
    ngx.status = status
    self.http_status = status
    return self
end

function M:render(tpl,data)
    tpl = "/app/views/"..tpl
    local t = tmpl.new(tpl)
    for k,v in pairs(data) do
        t[k] = v
    end
    local c = tostring(t)
    self:html(c)
end

function M:html(content)
    self:set_header('Content-Type', 'text/html; charset=UTF-8')
    ngx.status = 200
    ngx.say(content)
end

function M:json(data)
    self:set_header('Content-Type', 'application/json; charset=utf-8')
    ngx.status = 200
    ngx.say(json.encode(data))
end


return M
