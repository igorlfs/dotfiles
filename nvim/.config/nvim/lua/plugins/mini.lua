local status, indentscope = pcall(require, "mini.indentscope")

if not status then
    vim.notify("mini.indentscope not found")
    return
end

indentscope.setup({
    symbol = "│",
    draw = {
        delay = 0,
        animation = indentscope.gen_animation.none(),
    },
    options = {
        border = "top",
        try_as_border = true,
    },
})
