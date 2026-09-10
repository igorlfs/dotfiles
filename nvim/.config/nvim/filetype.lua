vim.filetype.add({
    pattern = {
        [".*/%.vscode/.*%.json"] = "jsonc",
        [".*/zed/.*%.json"] = "jsonc",
        [".*/sway/config.d/.*"] = "swayconfig",
        ["%.env%.[%w_.-]+"] = "sh",
        [".*/waybar/config"] = "jsonc",
        ["%.dev%.[%w_.-]+"] = "sh",
        [".sqruff"] = "ini",
    },
})
