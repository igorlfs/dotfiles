local rest = require("restaurus")

local api = vim.api

api.nvim_create_user_command("ReCord", function(args)
    require("restaurus").save(args.fargs[1], args.bang)
end, { nargs = 1, bang = true })

api.nvim_create_user_command("ReMove", function(args)
    require "restaurus".remove(args.fargs[1], args.bang)
end, { nargs = 1, bang = true })

api.nvim_create_user_command("ReName", function(args)
    require "restaurus".rename(args.fargs[1], args.fargs[2])
end, { nargs = "+" })

api.nvim_create_user_command("ReLoad", function()
    require "restaurus".list()
end, {})

api.nvim_create_user_command("ReCall", function()
    require "restaurus".restore_last()
end, {})

api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        local session_name = rest.session_name()

        if session_name and session_name ~= "__" then
            require("restaurus").save(session_name, true)
        else
            require("restaurus").save(nil, true)
        end
    end,
})
