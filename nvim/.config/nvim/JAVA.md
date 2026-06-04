## Packages

```sh
sudo pacman -S gradle
yay -S java-debug
yay -S jdtls
```

## Config

- `pluing/jdtls.lua`

```lua
local util = require("igorlfs.util")

vim.pack.add({
    { src = util.gh("mfussenegger/nvim-jdtls") },
})

vim.lsp.enable("jdtls")
```

- `lsp/jdtls.lua`

```lua
---@type lspconfig.settings.jdtls
return {
    init_options = {
        bundles = {
            "/usr/share/java-debug/com.microsoft.java.debug.plugin.jar",
        },
    },
}
```
