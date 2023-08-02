local jdtls_status, jdtls = pcall(require, "jdtls")
local mason_status, mason = pcall(require, "mason-registry")

if not jdtls_status then
    vim.notify("jdtls not found")
    return
end

if not mason_status then
    vim.notify("mason not found")
    return
end

local JDTLS_PATH = mason.get_package("jdtls"):get_install_path()
local JAVA_DEBUG_PATH = mason.get_package("java-debug-adapter"):get_install_path()
local JAVA_TEST_PATH = mason.get_package("java-test"):get_install_path()

-- Debugging
local bundles = {
    vim.fn.glob(JAVA_DEBUG_PATH .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
}
local extensions = vim.split(vim.fn.glob(JAVA_TEST_PATH .. "/extension/server/*.jar", true), "\n")
for _, extension in ipairs(extensions) do
    -- as of apr/23 this extension throws an error (albeit harmless)
    if not vim.endswith(extension, "com.microsoft.java.test.runner-jar-with-dependencies.jar") then
        table.insert(bundles, extension)
    end
end

-- Workspace
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local JDTLS_DATA = os.getenv("XDG_DATA_HOME") .. "/jdtls/" .. project_name

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
        "-javaagent:" .. JDTLS_PATH .. "/lombok.jar",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",

        "-jar",
        vim.fn.glob(JDTLS_PATH .. "/plugins/org.eclipse.equinox.launcher_*.jar", true),

        "-configuration",
        JDTLS_PATH .. "/config_linux",

        "-data",
        JDTLS_DATA,
    },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
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
                enabled = false,
            },
            references = {
                includeDecompiledSources = true,
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
        -- Enable debugging
        bundles = bundles,
    },
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)

local keymap = vim.keymap.set
-- Using jdtls's builtin method allows debugging, which neotest's adapter currently lacks
keymap("n", "<leader>td", jdtls.test_nearest_method, { desc = "[T]est [D]ebug" })
