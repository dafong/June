local M={}

function M:process(req,resp)
    local fs = {}
    ngx.log(ngx.ERR,"filters: "..#self.filters)
    for _,f in ipairs(self.filters) do
        if f.pattern == nil or ngx.re.match(req.path,f.pattern) then
            table.insert(fs, f.func)
        end

    end
    req.filters = fs
end

local utils = require"utils"

function M:init(conf)
    local c = conf.filters or {}
    if type(c) == "function" then
        c(self)
    end
end

function M:add(...)

    local p = {...}
    if #p == 0 then
        return
    end

    local check = function(p)
        if type(p) ~= "function" then
            error("error when add global filter #:"..#self.filters + 1)
        end
    end

    if #p == 1 then
        check(p[1])
        table.insert(self.filters,{pattern = nil , func = p[1] })
    else
        check(p[2])
        table.insert(self.filters,{pattern = p[1] , func = p[2] })
    end
end


setmetatable( M , {
    __tostring = function(t)

    end,

    __call = function(t,conf)
        local ins = {
            filters = {}
        }
        setmetatable(ins,{ __index = M })
        ins:init(conf)
    return ins
end})

return M
