vim.filetype.add({
    pattern = {
        [".*/%.vscode/.*%.json"] = "jsonc",
        [".*/zed/.*%.json"] = "jsonc",
        [".*/sway/config.d/.*"] = "swayconfig",
        [".*/waybar/config"] = "jsonc",
        ["%.env%.[%w_.-]+"] = function(path)
            return (path:find("%.sops%.") and not path:find("^/tmp")) and "jsonc" or "sh"
        end,
        ["%.dev%.[%w_.-]+"] = "sh",
        [".sqruff"] = "ini",
    },
})
