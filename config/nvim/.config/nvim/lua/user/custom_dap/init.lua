local daptext_ok, daptext = pcall(require, "nvim-dap-virtual-text")
if not daptext_ok then
  return
end

local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  return
end


local Remap = require("user.keymap")
local nnoremap = Remap.nnoremap
local inoremap = Remap.inoremap

-- add other configs here
daptext.setup()
dapui.setup({
  layouts = {
    {
      elements = {
        "console",
      },
      size = 7,
      position = "bottom",
    },
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "watches",
      },
      size = 40,
      position = "left",
    }
  },
})

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open(1)
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

require("user.custom_dap.node")
require("user.custom_dap.go_delve")

nnoremap("<leader>1", function()
  dapui.toggle(1)
end)
nnoremap("<leader>2", function()
  dapui.toggle(2)
end)

nnoremap("<Up>", function()
  dap.continue()
end)
nnoremap("<Down>", function()
  dap.step_over()
end)
nnoremap("<Right>", function()
  dap.step_into()
end)
nnoremap("<Left>", function()
  dap.step_out()
end)
nnoremap("<F8>", function()
  dap.toggle_breakpoint()
end)
