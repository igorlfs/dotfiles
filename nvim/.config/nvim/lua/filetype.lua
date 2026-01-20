vim.filetype.add({
    pattern = {
        [".*/%.vscode/.*%.json"] = "jsonc",
        [".*/zed/.*%.json"] = "jsonc",
        [".*/sway/config.d/.*"] = "swayconfig",
        [".*/waybar/config"] = "jsonc",
        ["%.dev%.[%w_.-]+"] = "sh",
        [".sqruff"] = "ini",
    },
})
