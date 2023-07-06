# Hyprland

![hyprland](https://github.com/igorlfs/dotfiles/assets/84649544/7de234d5-1f38-4ca6-b950-5913c6d69e01)
Not much to see here!

# Neovim

Fully featured config for multiple languages, like Python, C++, Rust and Javascript.

## Screenshots

![python](https://github.com/igorlfs/dotfiles/assets/84649544/9a966478-c7c4-4cfe-bc9f-bc6304ad2c6a)
Data analysis using [vim-jukit](https://github.com/luk400/vim-jukit) and [visidata](https://github.com/saulpw/visidata)

![rust](https://github.com/igorlfs/dotfiles/assets/84649544/39e260e2-d3d4-432b-bd6c-dbcd0609f0d2)
Sample Rust project

![latex](https://github.com/igorlfs/dotfiles/assets/84649544/f530e1c8-a08a-482a-9ad8-d6a96a8d1641)
Editing some $\LaTeX$

## Support

### Programming Languages

|  Language   |      LSP      |  Debugging[^1]   |  Linting   |  Formatting  | Testing[^2] |
| :---------: | :-----------: | :--------------: | :--------: | :----------: | :---------: |
|   Python    |    Pylance    |     debugpy      |    ruff    |    black     |   pytest    |
|     C++     |    clangd     |     codelldb     |  cppcheck  | clang-format |             |
|      C      |    clangd     |     codelldb     |  cppcheck  | clang-format |             |
|    Rust     | rust-analyzer |     codelldb     |   clippy   |   rustfmt    |   nextest   |
| Typescript  |   tsserver    | js-debug-adapter |            |              |    jest     |
| Javascript  |   tsserver    | js-debug-adapter |            |              |    jest     |
|    Java     |     jdtls     |    java-debug    |   jdtls    |    jdtls     |    junit    |
|     Lua     |    lua_ls     |                  |   selene   |    stylua    |             |
|    Shell    |    bashls     |                  | shellcheck |   shellfmt   |             |
|    Julia    |   julia-lsp   |                  |            |              |             |

Additionally, Python and Julia can be used in a REPL-like environment.

### Others

| Language |    LSP    |  Formatting  |
| :------: | :-------: | :----------: |
|   JSON   |  jsonls   |              |
|   YAML   |  yamlls   |   yamlfmt    |
|   TOML   |   taplo   |    taplo     |
|  LaTeX   |  texlab   | latexindent  |
|  BibTeX  |  texlab   |    texlab    |
| Markdown |           | markdownlint |
|  Gradle  | gradle_ls |              |
|   HTML   |   html    |              |
|   CSS    |   cssls   |              |

Both JSON and YAML have enhanced capabilities with [schemastore](https://www.schemastore.org/json/).
LaTeX and Markdown support live-preview.

[^1]: via [nvim-dap](https://github.com/mfussenegger/nvim-dap)
[^2]: via [neotest](https://github.com/nvim-neotest/neotest)
