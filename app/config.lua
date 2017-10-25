

return {
    redis = {

    },

    mysql = {
        host = "127.0.0.1",
        port = 3306,
        user = "root",
        password  = ""
    },

    http = {

        router = {

        },

        view = {

        },

        filters = function(f)

            -- custom global filter start
            -- f:add(require"filters.logfilter")

            -- default process filter
            f:add("june.http.filters.default")

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
