-- Inspired by https://github.com/Alexis12119/nvim-config/blob/main/ftplugin/java.lua

local status_ok, jdtls = pcall(require, "jdtls")
if not status_ok then
  return
end

local java_debug_path = vim.fn.stdpath "data" .. "/mason/packages/java-debug-adapter/"
local java_test_path = vim.fn.stdpath "data" .. "/mason/packages/java-test/"
local jdtls_path = vim.fn.stdpath "data" .. "/mason/packages/jdtls/"
local lombok_path = vim.fn.stdpath "data" .. "/mason/packages/jdtls/"

local bundles = {
  vim.fn.glob(java_debug_path .. "extension/server/com.microsoft.java.debug.plugin-*.jar", true),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "extension/server/*.jar", true), "\n"))

-- NOTE: Decrease the amount of files to improve speed(Experimental).
-- INFO: It's annoying to edit the version again and again.
local equinox_path = vim.split(vim.fn.glob(vim.fn.stdpath "data" .. "/mason/packages/jdtls/plugins/*jar"), "\n")
local equinox_launcher = ""

for _, file in pairs(equinox_path) do
  if file:match "launcher_" then
    equinox_launcher = file
    break
  end
end

WORKSPACE_PATH = vim.fn.stdpath "data" .. "/workspace/"
OS_NAME = "linux" -- TODO: Check which os is being used

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = WORKSPACE_PATH .. project_name

local config = {
  cmd = {
    -- 💀
    "/usr/lib/jvm/openlogic-openjdk-22.0.2+9-linux-x64/bin/java",

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. lombok_path  .. "lombok.jar",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    -- 💀
    "-jar",
    equinox_launcher,
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
    -- Must point to the                                                     Change this to
    -- eclipse.jdt.ls installation                                           the actual version
    -- 💀
    "-configuration",
    jdtls_path .. "config_" .. OS_NAME,
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
    -- Must point to the                      Change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation            Depending on your system.

    "-data",
    workspace_dir,
  },
  -- on_attach = require("plugins.lsp.opts").on_attach,
  -- replaced nvim cmp with blink
  capabilities = require('blink.cmp').get_lsp_capabilities(),
  -- capabilities = require("cmp_nvim_lsp").default_capabilities(),
  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require("jdtls.setup").find_root(root_markers),
  init_options = {
    bundles = bundles,
  },
  settings = {
    eclipse = {
      downloadSources = true,
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

    signatureHelp = { enabled = true },
    extendedClientCapabilities = require("jdtls").extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
  },
  flags = {
    allow_incremental_sync = true,
  },
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)
