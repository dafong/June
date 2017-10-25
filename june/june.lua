require"june.extension"

local Http = require"june.http"

local M = {
    conf = nil
}

function M:conf(conf)
    self.conf = conf
    return self
end

function M:create_http()
    local http = Http:new(self.conf)
    return http
end

function M:create_socket()

end


return M
