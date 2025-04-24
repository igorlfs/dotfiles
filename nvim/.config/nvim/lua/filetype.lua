vim.filetype.add({
    pattern = {
        [".*/%.vscode/.*%.json"] = "jsonc",
        [".*/zed/.*%.json"] = "jsonc",
        [".*/sway/config.d/.*"] = "swayconfig",
        [".*/waybar/config"] = "jsonc",
        ["%.env%.[%w_.-]+"] = "sh",
        ["%.dev%.[%w_.-]+"] = "sh",
    },
})
