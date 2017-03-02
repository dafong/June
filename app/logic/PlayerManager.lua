
local robotservice = require("logic.RobotService")

local players = {}

local player = {
    init = function(self)
        self.status = 0  -- 0 offline  1 online
        self.token  = nil
        self.acct = {
            pid  = 0
            name = nil
            pwd  = nil
        }
        self.setting={
            task=false,rob=false,farm=false,boss = false
        },
        self.info = {
            robstatus = 0
        },
        self.robot = robotservice:new()
    end,

    new = function(self)
        local ins = {}
        setmetatable(ins,{ __index = self })
        return ins
    end
}

local M={}

function M:players()

end

function M:player(pid)
    return players[pid]
end

function M:addorupdate(player)
    local p = players[player.pid]
    if not p then
        p = player:new()
        players[player.pid] = p
    end
    p.acct.name = player.name
    p.acct.pwd  = player.pwd
    p.acct.pid  = player.pid
end

function M.online(pid)
    local p = players[pid]
    if not p then return end
    p.robot:online()
end

function M.offline(id)
    local p = players[pid]
    if not p then return end
    p.robot:offline()
end

function M:setting(pid,setting)
    local p = players[pid]
    if not p then return end
    p.setting.task = false
    p.setting.rob  = false
    p.setting.famr = false
    p.setting.boss = false
    p.robot:syncsetting()
end


return M
