local utils = require"utils"
local log = require"june.log"
local mysql = require"resty.mysql"

local M={

}

function M:use(conf)
    self.db = mysql.new()
end




return M
