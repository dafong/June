

return {
    redis = {
        host = "127.0.0.1",
        port = 6379
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
            
            -- custom url mapping filter start
            f:add("/auth","filters.authfilter")
            -- default process filter
            f:add("june.http.filters.default")



        end,
    },

    socket = {
        modules = function(j)
            -- you can add a new or replace a module here
            include_mysql_redis(j)
        end,
    }

}
