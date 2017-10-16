
local function include_mysql_redis(j)
    -- j:enable(require("june.modules.mysql"))
    -- j:enable(require("june.modules.redis"))
end

return {
    redis = {

    },


    mysql = {

    },

    http = {
        modules = function(j)
            -- you can add a new or replace a module here
            include_mysql_redis(j)
        end,

        router = {

        },

        view = {

        },

        filters = function(f)
            -- june default start
            -- j:add(require"june.http.filters.session")

            -- custom global filter start
            -- f:add(require"filters.logfilter")

            -- default process filter
            f:add(require"june.http.filters.default")

            -- custom url mapping filter start
            -- f:add("/auth",require"filters.authfilter")

        end,
    },

    socket = {
        modules = function(j)
            -- you can add a new or replace a module here
            include_mysql_redis(j)
        end,
    }

}
