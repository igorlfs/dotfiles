vim.filetype.add({
    pattern = {
        [".*/%.vscode/.*%.json"] = "jsonc",
        [".*/zed/.*%.json"] = "jsonc",
        [".*/hypr/.+%.conf"] = "hyprlang",
        [".*/sway/config.d/.*"] = "swayconfig",
        [".*/waybar/config"] = "jsonc",
        ["%.env%.[%w_.-]+"] = "sh",
    },
})
