
local Request  = require"june.http.request"
local Response = require"june.http.response"
local log = require"june.log"

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

    if self.modules.cookie == nil then
        self:enable("cookie",require("june.http.modules.cookie"))
    end
end

function M:enable(name,mod)
    if self.modules[name] ~= nil then
        error("module with same name " .. name .." already exist")
    end
    self.modules[name] = mod(name,self.conf)
end

function M:run()
    local req  = Request:new()
    local resp = Response:new()
    -- iterator all modules

    for n,m in pairs(self.modules) do
        log:d("process module: "..n)
        m:process(req,resp)
    end

    -- iterator all filters
    local filters = req.filter.all or {}

    for _,f in ipairs(filters) do
        if f(req,resp) == false then
            break
        end
    end
end

return M
