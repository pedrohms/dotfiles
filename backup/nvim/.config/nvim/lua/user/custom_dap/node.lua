local dap = require('dap')
dap.adapters.jsdebug = {
  type = 'executable',
  name = 'jsdebug',
  command = 'node',
  args = { vim.fn.stdpath "data" .. '/mason/packages/js-debug-adapter/out/src/debugServerMain.js', "45635" },
}

dap.adapters.node2 = {
  type = 'executable',
  name = 'node2',
  command = 'node',
  args = { vim.fn.stdpath "data" .. '/mason/packages/node-debug2-adapter/out/src/nodeDebug.js' }
}

dap.adapters['pwa-node'] = {
  type = 'server',
  host = '127.0.0.1',
  port = 45635,
}

dap.configurations.javascript = {
  {
    name = 'Launch node2',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    name = 'node2 - Attach to process',
    type = 'node2',
    request = 'attach',
    processId = require('dap.utils').pick_process,
  },
  {
    name = 'Launch jsdebug',
    type = 'jsdebug',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    name = 'jsdebug - Attach to process',
    type = 'jsdebug',
    request = 'attach',
    debugServer = 45635
  },
  {
    type = 'pwa-node',
    request = 'launch',
    name = 'Launch program',
    program = '${file}',
  },
}

dap.configurations.typescript = {
  {
    name = "ts-node (Node2 with ts-node)",
    type = "node2",
    request = "launch",
    cwd = vim.loop.cwd(),
    runtimeArgs = { "-r", "ts-node/register" },
    runtimeExecutable = "node",
    args = { "--inspect", "${file}" },
    sourceMaps = true,
    skipFiles = { "<node_internals>/**", "node_modules/**" },
  },
  {
    name = "Jest (Node2 with ts-node)",
    type = "node2",
    request = "launch",
    cwd = vim.loop.cwd(),
    runtimeArgs = { "--inspect-brk", "${workspaceFolder}/node_modules/.bin/jest" },
    runtimeExecutable = "node",
    args = { "${file}", "--runInBand", "--coverage", "false" },
    sourceMaps = true,
    port = 9229,
    skipFiles = { "<node_internals>/**", "node_modules/**" },
  },
}
