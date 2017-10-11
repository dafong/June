local json = require"cjson"
local tmpl = require"resty.template"

local M = {}

function M:new()
    local ins = {

    }
    setmetatable(ins , { __index = self })
    return ins
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
