local system = os.getenv "OS"
if system == "Windows_NT" then
  CONFIG = "win"
else
  CONFIG = "linux"
end
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)

-- if (root_dir == nil) or (root_dir == "") then
--   return
-- end

local workspace_dir = root_dir

local bundles = {
  vim.fn.glob(
    vim.fn.stdpath "data" .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
  ),
}

vim.list_extend(bundles,
  vim.split(vim.fn.glob(vim.fn.stdpath "data" .. "/mason/packages/java-test/extension/server/*.jar"), "\n"))

local config = {
  on_attach = function()
    vim.lsp.codelens.refresh()
    require("jdtls").setup_dap { hotcodereplace = "auto" }
    require("jdtls.dap").setup_dap_main_class_configs()
  end,
  filetypes = { "java" },
  flags = {
    debounce_text_changes = 80,
    allow_incremental_sync = true,
  },
  handlers = {},
  init_options = {
    bundles = bundles,
  },
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
      signatureHelp = { enabled = true },
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
      filteredTypes = {
        "com.sun.*",
        "io.micrometer.shaded.*",
        "java.awt.*",
        "jdk.*",
        "sun.*",
      },
    },
    contentProvider = { preferred = "fernflower" },
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
      hashCodeEquals = {
        useJava7Objects = true,
      },
      useBlocks = true,
    },
  },
  cmd = {
    os.getenv("JAVA_HOME") .. "/bin/java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-DwatchParentProcess=false",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    vim.fn.glob(vim.fn.stdpath "data" .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration",
    vim.fn.stdpath "data" .. "/mason/packages/jdtls/config_" .. CONFIG,
    "-data",
    vim.fn.stdpath "cache" .. "/jdtls",
    "-XX:+UseParallelGC",
    "-XX:GCTimeRatio=4",
    "-XX:AdaptiveSizePolicyWeight=90",
    "-Djava.import.generatesMetadataFilesAtProjectRoot=false",
    "-Dsun.zip.disableMemoryMapping=true",
    "-Xmx512M",
    "-Xms100m",
    "-javaagent:" .. vim.fn.stdpath "data" .. "/mason/packages/jdtls/lombok.jar",
  }
}

require "jdtls".start_or_attach(config)

local Remap = require("user.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap
local vnoremap = Remap.vnoremap

nnoremap("<leader>lpc", function() require("jdtls").update_project_config() end)
nnoremap("gd", function() vim.lsp.buf.definition() end)
nnoremap("K", function() vim.lsp.buf.hover() end)
nnoremap("<leader>lws", function() vim.lsp.buf.workspace_symbol() end)
nnoremap("<leader>ld", function() vim.diagnostic.open_float() end)
nnoremap("[d", function() vim.diagnostic.goto_next() end)
nnoremap("]d", function() vim.diagnostic.goto_prev() end)
nnoremap("<leader>lca", function() vim.lsp.buf.code_action() end)
nnoremap("<leader>lrf", function() vim.lsp.buf.references() end)
nnoremap("<leader>lrn", function() vim.lsp.buf.rename() end)
inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)
inoremap("<C-K>", function() vim.lsp.buf.hover() end)
-- nnoremap("<leader>lds", "<cmd>Telescope lsp_document_symbols<cr>")
nnoremap("<F12>", function() require("telescope.builtin").lsp_document_symbols(require("telescope.themes")
    .get_dropdown { previewer = false })
end)
-- if vim.lsp.buf["format"] == nil then
--   nnoremap("<leader>lf", function() vim.lsp.buf.formatting() end)
-- else
nnoremap("<leader>lf", function() vim.lsp.buf.format { async = true } end)
vnoremap("<leader>lrf", function() vim.lsp.buf.range_formatting() end)
-- end
-- vim.lsp.codelens.refresh()
--
-- require("jdtls.dap").setup_dap_main_class_configs()
