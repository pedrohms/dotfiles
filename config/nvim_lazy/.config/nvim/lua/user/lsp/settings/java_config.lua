local system = os.getenv "OS"
if system == "Windows_NT" then
  CONFIG = "win"
else
  CONFIG = "linux"
end
-- local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
-- local root_dir = require("jdtls.setup").find_root(root_markers)

-- if (root_dir == nil) or (root_dir == "") then
--   return
-- end

local workspace_dir = vim.fn.getcwd()

local bundles = {
  vim.fn.glob(
    vim.fn.stdpath "data" ..
    "/custom/dap/jdtls/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
  ),
}

vim.list_extend(bundles,
  vim.split(vim.fn.glob(vim.fn.stdpath "data" .. "/custom/dap/jdtls-test/vscode-java-test/server/*.jar"), "\n"))

local function on_language_status(_, result)
  local command = vim.api.nvim_command
  if result.message ~= nil then
    command 'echohl ModeMsg'
    command(string.format('echo "%s"', result.message))
    command 'echohl None'
  end
end

return {
  filetypes = { "java" },
  flags = {
    debounce_text_changes = 80,
    allow_incremental_sync = true,
  },
  handlers = {
    ['$/progress'] = vim.schedule_wrap(on_language_status),
  },
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
    workspace_dir,
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
