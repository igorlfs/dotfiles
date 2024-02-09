vim.filetype.add({
    pattern = {
        [".*/%.vscode/.*%.json"] = "jsonc",
        ["~/dotfiles/waybar/.config/waybar/config"] = "jsonc",
        ["~/dotfiles/hyprland/.*"] = "hyprlang",
    },
})
