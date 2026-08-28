local lsp = vim.lsp

lsp.linked_editing_range.enable()
lsp.on_type_formatting.enable()

lsp.config("*", {
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                -- Enable file watching for LSP
                --
                -- It's disabled because the default implementation is considered slow.
                dynamicRegistration = true,
            },
        },
    },
})

lsp.handlers["client/registerCapability"] = (function(overridden)
    return function(err, res, ctx)
        local result = overridden(err, res, ctx)
        local client = lsp.get_client_by_id(ctx.client_id)
        if not client then
            return
        end
        for buf, _ in pairs(client.attached_buffers) do
            -- Based on an example from the docs (LspAttach)
            -- Deals with features that may depend on dynamic registration (e.g., formatting for ty)
            require("igorlfs.util").lsp_auto_format(client, buf)
        end
        return result
    end
end)(lsp.handlers["client/registerCapability"])
