require"june.extension"

local Http = require"june.http"

local June = {}

function June:create_http(conf)
    local http = Http:new(conf)
    return http
end

function June:create_socket()

end


return June
