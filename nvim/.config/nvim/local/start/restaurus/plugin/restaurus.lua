local api = vim.api

api.nvim_create_user_command("ReCord", function(args)
    local this_session = require("restaurus").session_name()
    local name_ = args.fargs[1] or (this_session ~= "__" and this_session) or nil

    require("restaurus").save(name_, args.bang)
end, { nargs = "?", bang = true })

api.nvim_create_user_command("ReMove", function(args)
    require("restaurus").remove(args.fargs[1], args.bang)
end, {
    nargs = "?",
    bang = true,
    complete = function(arg_lead, cmdline)
        return require("restaurus").complete_session_names(arg_lead, cmdline)
    end,
})

api.nvim_create_user_command("ReName", function(args)
    require("restaurus").rename(args.fargs[1], args.fargs[2])
end, {
    nargs = "*",
    complete = function(arg_lead, cmdline)
        return require("restaurus").complete_session_names(arg_lead, cmdline)
    end,
})

api.nvim_create_user_command("ReLoad", function()
    require("restaurus").list()
end, {})

api.nvim_create_user_command("ReCall", function()
    require("restaurus").restore_last()
end, {})

api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        local session_name = require("restaurus").session_name()

        if session_name and session_name ~= "__" then
            require("restaurus").save(session_name, true)
        else
            require("restaurus").save(nil, true)
        end
    end,
})
