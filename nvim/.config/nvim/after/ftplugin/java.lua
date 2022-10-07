local jdtls = require("jdtls")

-- Language Server location
local JDTLS_LOCATION = "/usr/share/java/jdtls"

-- Debugger location
local DEBUGGER_LOCATION = os.getenv "HOME" .. "/aur/java-debug"
local DEBUG_EXTENSION_LOCATION = os.getenv("HOME") .. "/aur/vscode-java-test"

-- Debugging
local bundles = {
    vim.fn.glob(
        DEBUGGER_LOCATION .. "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
    ),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(DEBUG_EXTENSION_LOCATION .. "/server/*.jar"), "\n"))

-- Workspace
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
-- Probably messed up as I'm not currently using a build system
local workspace_dir = os.getenv("HOME") .. "/code/java-wsd/" .. project_name

-- Additional capabilities
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {

        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",

        "-jar", vim.fn.glob(JDTLS_LOCATION .. "/plugins/org.eclipse.equinox.launcher_*.jar"),

        "-configuration", JDTLS_LOCATION .. "/config_linux",

        "-data", workspace_dir,
    },

    on_attach = require("plugins.lsp").on_attach,
    capabilities = require("plugins.lsp").capabilities,
    handlers = require("plugins.lsp").handlers,

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            format = {
                enabled = true,
            },
        },
        signatureHelp = { enabled = true },
        completion = {
            favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
            },
        },
        contentProvider = { preferred = "fernflower" },
        extendedClientCapabilities = extendedClientCapabilities,
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
        },
    },

    flags = {
        allow_incremental_sync = true,
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        bundles = bundles,
    },
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)


local keymap = vim.keymap.set

keymap("n", "<leader>tc", jdtls.test_class)
keymap("n", "<leader>tm", jdtls.test_nearest_method)
