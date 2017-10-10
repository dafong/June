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
    local t = tmpl(tpl)
    for k,v in pairs(data) do
        t[k] = v
    end
    local c = tostring(t)
    self:output(200,c)
end

function M:output(status,content)
    ngx.status = status
    ngx.say(content)
end

-- function M:json(data)
--     self:set_header('Content-Type', 'application/json; charset=utf-8')
--     self:output(200,json.encode(data))
-- end


return M
