local M = {}

local uv = vim.uv
local fs = vim.fs
local fn = vim.fn
local lvl = vim.log.levels

local LOCAL_SESSIONS_PATH = ".nvim/sessions"
local SHARED_SESSIONS_PATH = fn.stdpath("state") .. "/restaurus"

if uv.fs_stat(SHARED_SESSIONS_PATH) == nil then
    fs.mkdir(SHARED_SESSIONS_PATH, { parents = true })
end

---@param name string?
---@param force boolean?
M.save = function(name, force)
    local git_root = fs.root(0, ".git")

    local root = git_root and git_root or uv.cwd()

    vim._with({ cwd = root }, function()
        local session_file_name = name and string.format("%s/%s.vim", LOCAL_SESSIONS_PATH, name)
            or string.format("%s/__.vim", SHARED_SESSIONS_PATH)

        if name then
            local session_dir_stat = uv.fs_stat(LOCAL_SESSIONS_PATH)

            if not (session_dir_stat ~= nil and session_dir_stat.type == "directory") then
                fs.mkdir(LOCAL_SESSIONS_PATH, { parents = true })
            elseif uv.fs_stat(session_file_name) and not force then
                vim.notify(string.format("Session %s already exists", name), lvl.ERROR)

                return
            end
        end

        local abs_path_session = fs.abspath(session_file_name)

        vim.cmd("mksession! " .. abs_path_session)

        if name then
            local root_base_name = fs.basename(root)

            local link_path = string.format("%s/%s+%s.vim", SHARED_SESSIONS_PATH, root_base_name, name)

            uv.fs_symlink(abs_path_session, link_path)

            vim.v.this_session = link_path
        end
    end)
end

M.list = function()
    ---@type string[]
    local files = {}
    for file_name, type in fs.dir(SHARED_SESSIONS_PATH) do
        if type == "link" and vim.endswith(file_name, ".vim") then
            files[#files + 1] = file_name
        end
    end

    -- Courtesy of possession
    -- https://github.com/jedrzejboczar/possession.nvim/blob/fbea95b16c284727bc8deff2c3780a73efcdaca6/lua/possession/query.lua#L36-L44
    ---@param file string
    ---@return integer
    local get_time = function(file)
        local stat = uv.fs_stat(string.format("%s/%s", SHARED_SESSIONS_PATH, file))
        if stat == nil then
            return 0
        end
        local t = stat["mtime"]
        -- use millis to fit in Lua's max float "integer precision" of 53 bits
        return math.floor(t.sec * 1000 + t.nsec / 1000000)
    end

    table.sort(files, function(a, b)
        return get_time(a) > get_time(b)
    end)

    if vim.tbl_isempty(files) then
        vim.notify("No sessions found", lvl.WARN)

        return
    end

    vim.ui.select(files, {
        prompt = "Pick session: ",
        ---@param item string
        format_item = function(item)
            return (item:gsub("+", "/", 1):gsub(".vim$", ""))
        end,
    }, function(item)
        if item then
            -- Vim(normal):Can't re-enter normal mode from terminal mode
            vim.defer_fn(function()
                vim.cmd("source " .. SHARED_SESSIONS_PATH .. "/" .. item)
            end, 10)
        end
    end)
end

---@param name string
M.remove = function(name, force)
    if not force then
        local choice = fn.confirm(string.format("Remove session %s?", name), "&Yes\n&No")
        if choice == 2 then
            return
        end
    end

    local git_root = fs.root(0, ".git")

    local root = git_root and git_root or uv.cwd()

    local base_name = fs.basename(root)
    local link_path = string.format("%s/%s+%s.vim", SHARED_SESSIONS_PATH, base_name, name)

    uv.fs_unlink(link_path)

    vim._with({ cwd = root }, function()
        local session_file_name = string.format("%s/%s.vim", LOCAL_SESSIONS_PATH, name)

        if uv.fs_stat(session_file_name) then
            fs.rm(session_file_name)
        end

        if vim.v.this_session == link_path then
            vim.v.this_session = ""
        end
    end)
end

---@param name string
---@param new_name? string
M.rename = function(name, new_name)
    if new_name == nil then
        vim.ui.input({ prompt = "New name: ", default = name }, function(input)
            if input then
                new_name = input
            end
        end)

        if new_name == nil then
            return
        end
    end

    local git_root = fs.root(0, ".git")

    local root = git_root and git_root or uv.cwd()

    local base_name = fs.basename(root)

    local sessions_dir = string.format("%s/%s", root, LOCAL_SESSIONS_PATH)

    local new_session_file_name = string.format("%s/%s.vim", LOCAL_SESSIONS_PATH, new_name)

    local abs_path_new_session = fs.abspath(new_session_file_name)

    vim._with({ cwd = sessions_dir }, function()
        local original_path = string.format("%s.vim", name)
        local new_path = string.format("%s.vim", new_name)

        if uv.fs_stat(new_path) then
            vim.notify(string.format("Session '%s' already exists", new_name), lvl.ERROR)
            return
        end

        if uv.fs_stat(original_path) then
            uv.fs_rename(original_path, new_path)
        end
    end)

    vim._with({ cwd = SHARED_SESSIONS_PATH }, function()
        local original_link_path = string.format("%s+%s.vim", base_name, name)

        local original_link_abs_path = fs.abspath(original_link_path)

        uv.fs_unlink(original_link_path)

        local new_link_path = string.format("%s+%s.vim", base_name, new_name)

        uv.fs_symlink(abs_path_new_session, new_link_path)

        local abs_path_link = fs.abspath(new_link_path)

        if vim.v.this_session == original_link_abs_path then
            vim.v.this_session = abs_path_link
        end
    end)
end

-- TODO: save last N sessions?
M.restore_last = function()
    local last_session = string.format("%s/__.vim", SHARED_SESSIONS_PATH)

    vim.cmd("source " .. last_session)
end

---@return string?
M.session_name = function()
    local this_session = vim.v.this_session

    if this_session == "" then
        return
    end

    local session_path = fn.fnamemodify(this_session, ":h")

    if session_path == nil then
        return
    end

    local owned = session_path == SHARED_SESSIONS_PATH

    if not owned then
        return
    end

    local full_session_name = fn.fnamemodify(this_session, ":t:r")

    local session_name = full_session_name:gsub(".*+", "")

    return session_name
end

---@param arg_lead string
---@param cmdline string
M.complete_session_names = function(arg_lead, cmdline)
    if cmdline:match("%w %w") then
        return
    end

    local git_root = fs.root(0, ".git")

    local root = git_root and git_root or uv.cwd()

    local sessions_dir = string.format("%s/%s", root, LOCAL_SESSIONS_PATH)

    ---@type string[]
    local files = {}
    for file_name in fs.dir(sessions_dir) do
        if vim.endswith(file_name, ".vim") then
            files[#files + 1] = file_name:gsub("%.vim$", "")
        end
    end

    return vim.iter(files)
        :filter(function(file)
            return file:find(arg_lead or "") == 1
        end)
        :totable()
end

return M
