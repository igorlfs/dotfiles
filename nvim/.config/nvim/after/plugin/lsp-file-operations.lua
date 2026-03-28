local api = require("nvim-tree.api")

local event = api.events.Event

local TIMEOUT_MS = 1000

vim.lsp.config("*", {
    capabilities = {
        workspace = {
            fileOperations = {
                didCreate = true,
                didDelete = true,
                didRename = true,
                willCreate = true,
                willDelete = true,
                willRename = true,
            },
        },
    },
})

---@param response string | any
---@param offset_encoding lsp.PositionEncodingKind
local apply_workspace_edit = function(response, offset_encoding)
    if type(response) == "string" then
        vim.notify("LSP error: " .. response)
    end

    if response and response.err then
        vim.notify("LSP error: " .. response.err)
    end

    if response and response.result then
        ---@type integer[]
        local bufs = {}
        local document_changes = vim.tbl_get(response.result, "documentChanges")
        for _, doc in ipairs(document_changes or {}) do
            local uri = vim.tbl_get(doc, "textDocument", "uri")
            if uri then
                bufs[#bufs + 1] = vim.uri_to_bufnr(uri)
            end
        end

        vim.lsp.util.apply_workspace_edit(response.result, offset_encoding)

        for _, bufnr in ipairs(bufs) do
            vim.api.nvim_buf_call(bufnr, function()
                vim.cmd("write")
            end)
        end
    end
end

---@param fname string
---@param filters lsp.FileOperationFilter[]?
local has_match = function(fname, filters)
    local stat = vim.uv.fs_stat(fname)

    -- https://github.com/luvit/luv/blob/f65fe9d7616f9fbcd20227fc7a73b38d1c5c180d/src/fs.c#L131-L139
    local is_dir = stat and stat.type == "directory"
    local is_file = stat and stat.type == "file"

    return vim.iter(filters or {}):any(
        ---@param filter lsp.FileOperationFilter
        function(filter)
            local pattern = filter.pattern
            local match_type = pattern.matches

            if not match_type or (match_type == "file" and is_file) or (match_type == "folder" and is_dir) then
                local options = pattern.options

                local glob = options and options.ignoreCase and pattern.glob:lower() or pattern.glob
                local file_pat = options and options.ignoreCase and fname:lower() or fname

                return vim.glob.to_lpeg(glob):match(file_pat)
            end

            return false
        end
    )
end

api.events.subscribe(
    event.NodeRenamed,
    ---@param payload {old_name: string, new_name: string}
    function(payload)
        for _, client in ipairs(vim.lsp.get_clients()) do
            ---@type lsp.FileOperationRegistrationOptions?
            local did_rename = vim.tbl_get(client, "server_capabilities", "workspace", "fileOperations", "didRename")

            if has_match(payload.new_name, (did_rename or {}).filters) then
                local oldUri = vim.uri_from_fname(payload.old_name)
                local newUri = vim.uri_from_fname(payload.new_name)

                client:notify("workspace/didRenameFiles", {
                    files = { { oldUri = oldUri, newUri = newUri } },
                })
            end
        end
    end
)

for _, event_removed in ipairs({ event.FileRemoved, event.FolderRemoved }) do
    api.events.subscribe(
        event_removed,
        ---@param payload {fname: string} | {folder_name: string}
        function(payload)
            local node = payload.fname or payload.folder_name

            for _, client in ipairs(vim.lsp.get_clients()) do
                ---@type lsp.FileOperationRegistrationOptions?
                local did_delete =
                    vim.tbl_get(client, { "server_capabilities", "workspace", "fileOperations", "didDelete" })

                if has_match(node, (did_delete or {}).filters) then
                    local uri = vim.uri_from_fname(node)

                    client:notify("workspace/didDeleteFiles", { files = { { uri = uri } } })
                end
            end
        end
    )
end

for _, event_created in ipairs({ event.FileCreated, event.FolderCreated }) do
    api.events.subscribe(
        event_created,
        ---@param payload {fname: string} | {folder_name: string}
        function(payload)
            local node = payload.fname or payload.folder_name

            for _, client in ipairs(vim.lsp.get_clients()) do
                ---@type lsp.FileOperationRegistrationOptions?
                local did_create =
                    vim.tbl_get(client, { "server_capabilities", "workspace", "fileOperations", "didCreate" })

                if has_match(node, (did_create or {}).filters) then
                    local uri = vim.uri_from_fname(node)

                    client:notify("workspace/didCreateFiles", { files = { { uri = uri } } })
                end
            end
        end
    )
end

api.events.subscribe(
    event.WillRenameNode,
    ---@param payload {old_name: string, new_name: string}
    function(payload)
        for _, client in ipairs(vim.lsp.get_clients()) do
            ---@type lsp.FileOperationRegistrationOptions?
            local will_rename = vim.tbl_get(client, "server_capabilities", "workspace", "fileOperations", "willRename")

            if has_match(payload.old_name, (will_rename or {}).filters) then
                local oldUri = vim.uri_from_fname(payload.old_name)
                local newUri = vim.uri_from_fname(payload.new_name)

                local response = client:request_sync("workspace/willRenameFiles", {
                    files = { { oldUri = oldUri, newUri = newUri } },
                }, TIMEOUT_MS)

                apply_workspace_edit(response, client.offset_encoding)
            end
        end
    end
)

api.events.subscribe(
    event.WillRemoveFile,
    ---@param payload {fname: string}
    function(payload)
        for _, client in ipairs(vim.lsp.get_clients()) do
            ---@type lsp.FileOperationRegistrationOptions?
            local will_delete = vim.tbl_get(client, "server_capabilities", "workspace", "fileOperations", "willDelete")

            if has_match(payload.fname, (will_delete or {}).filters) then
                local uri = vim.uri_from_fname(payload.fname)

                local response = client:request_sync("workspace/willDeleteFiles", {
                    files = { { uri = uri } },
                }, TIMEOUT_MS)

                apply_workspace_edit(response, client.offset_encoding)
            end
        end
    end
)

api.events.subscribe(
    event.WillCreateFile,
    ---@param payload {fname: string}
    function(payload)
        for _, client in ipairs(vim.lsp.get_clients()) do
            ---@type lsp.FileOperationRegistrationOptions?
            local will_create = vim.tbl_get(client, "server_capabilities", "workspace", "fileOperations", "willCreate")

            if has_match(payload.fname, (will_create or {}).filters) then
                local uri = vim.uri_from_fname(payload.fname)

                local response = client:request_sync("workspace/willCreateFiles", {
                    files = { { uri = uri } },
                }, TIMEOUT_MS)

                apply_workspace_edit(response, client.offset_encoding)
            end
        end
    end
)
