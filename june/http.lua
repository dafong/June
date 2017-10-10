
local Request  = require"june.http.request"
local Response = require"june.http.response"


local M={}

function M:new(conf)
    local ins = {
        modules = {},
        conf    = conf.http or {}
    }
    setmetatable(ins,{__index = self})
    ins:_init()
    return ins
end

function M:_init()
    local mf = self.conf.modules
    if mf == nil then return end
    if type(mf) ~= "function" then
        return
    end
    mf(self)
    self:_check_default_module()
end

function M:_check_default_module()
    if self.modules.router == nil then
        self:enable("router",require("june.http.modules.router"))
    end

    if self.modules.filter == nil then
        self:enable("filter",require("june.http.modules.filter"))
    end
end

function M:enable(name,mod)
    if self.modules[name] ~= nil then
        error("module with same name " .. name .." already exist")
    end
    self.modules[name] = mod(self.conf)
end

function M:run()
    local req  = Request:new()
    local resp = Response:new()
    -- iterator all modules

    for n,m in pairs(self.modules) do
        ngx.log(ngx.ERR,"process module: "..n)
        m:process(req,resp)
    end

    -- iterator all filters
    req.filters = req.filters or {}

    for _,f in ipairs(req.filters) do
        if f(req,resp) == false then
            break
        end
    end
end

return M
