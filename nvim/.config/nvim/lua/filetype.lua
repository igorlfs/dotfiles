vim.filetype.add({
    pattern = {
        [".*/%.vscode/.*%.json"] = "jsonc",
        ["~/dotfiles/hyprland/.*"] = "hyprlang",
    },
    filename = {
        ["~/dotfiles/waybar/.config/waybar/config"] = "jsonc",
        ["zathurarc"] = "zathurarc",
    },
})
