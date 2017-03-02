local M = {}

function M:online()
    --try to login with the info
end

function M:offline()
    --try to logout with the info
    self.player.status = 0
end

function M:syncsetting()

end

function M:init(player)
    self.player = player
end

function M:new(player)
    local ins = {}
    setmetatable(ins,{ __index = self })
    ins:init(player)
    return ins
end

return M
