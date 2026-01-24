local e = vim.env

-- Prepend mise shims to PATH
e.PATH = e.HOME .. "/.local/share/mise/shims:" .. e.PATH
