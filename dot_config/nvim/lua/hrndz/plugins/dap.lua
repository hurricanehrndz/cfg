---@diagnostic disable: missing-parameter
local has_dap, dap = pcall(require, "dap")

if not has_dap then
  return
end

local signs = {
  breakpoint = {
    text = "",
    texthl = "LspDiagnosticsSignError",
    linehl = "",
    numhl = "",
  },
  breakpoint_rejected = {
    text = "",
    texthl = "LspDiagnosticsSignHint",
    linehl = "",
    numhl = "",
  },
  stopped = {
    text = "",
    texthl = "LspDiagnosticsSignInformation",
    linehl = "DiagnosticUnderlineInfo",
    numhl = "LspDiagnosticsSignInformation",
  },
}
vim.fn.sign_define("DapBreakpoint", signs.breakpoint)
vim.fn.sign_define("DapBreakpointRejected", signs.breakpoint_rejected)
vim.fn.sign_define("DapStopped", signs.stopped)

local debug_python = vim.fn.expand(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
if vim.fn.executable(debug_python) then
  local dap_python = require("dap-python")
  dap_python.setup(debug_python)
  print(debug_python)
end

local has_dapui, dapui = pcall(require, "dapui")
if not has_dapui then
  return
end

require("dapui").setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- keybinds with which-key
local has_wk, wk = pcall(require, "which-key")
if not has_wk then
  return
end

wk.register({
  d = {
    name = "Debug",
    b = { "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", "Breakpoint" },
    c = { "<Cmd>lua require'dap'.continue()<CR>", "Continue" },
    C = { "<Cmd>Telescope dap commands<CR>", "List Commands" },
    f = { "<Cmd>Telescope dap frames<CR>", "List Commands" },
    B = { "<Cmd>Telescope dap list_breakpoints<CR>", "List Breakpoint" },
    v = { "<Cmd>Telescope dap variables<CR>", "Variables" },
    i = { "<Cmd>lua require'dap'.step_into()<CR>", "Into" },
    o = { "<Cmd>lua require'dap'.step_over()<CR>", "Over" },
    O = { "<Cmd>lua require'dap'.step_out()<CR>", "Out" },
    r = { "<Cmd>lua require'dap'.repl.toggle()<CR>", "Repl" },
    l = { "<Cmd>lua require'dap'.run_last()<CR>", "Last" },
    u = { "<Cmd>lua require'dapui'.toggle()<CR>", "UI" },
    x = { "<Cmd>lua require'dap'.terminate()<CR>", "Exit" },
  },
}, { prefix = "<space>" })
