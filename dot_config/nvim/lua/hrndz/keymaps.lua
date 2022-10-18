local api = vim.api

local nmap = { noremap = true }
-- Ctrl+[hjkl] navigate cursor in insert or command mode
api.nvim_set_keymap("i", "<C-h>", "<Left>", nmap)
api.nvim_set_keymap("c", "<C-h>", "<Left>", nmap)
api.nvim_set_keymap("i", "<C-j>", "<Down>", nmap)
api.nvim_set_keymap("c", "<C-j>", "<Down>", nmap)
api.nvim_set_keymap("i", "<C-k>", "<Up>", nmap)
api.nvim_set_keymap("c", "<C-k>", "<Up>", nmap)
api.nvim_set_keymap("i", "<C-l>", "<Right>", nmap)
api.nvim_set_keymap("c", "<C-l>", "<Right>", nmap)

-- tmux navigator
vim.g.tmux_navigator_no_mappings = 1
-- Alt+[hjkl] navigate windows
api.nvim_set_keymap("n", "<A-h>", [[<cmd>TmuxNavigateLeft<CR>]], nmap)
api.nvim_set_keymap("n", "<A-j>", [[<cmd>TmuxNavigateDown<CR>]], nmap)
api.nvim_set_keymap("n", "<A-k>", [[<cmd>TmuxNavigateUp<CR>]], nmap)
api.nvim_set_keymap("n", "<A-l>", [[<cmd>TmuxNavigateRight<CR>]], nmap)
-- Alt+[hjkl] navigate windows from terminal
api.nvim_set_keymap("t", "<A-h>", [[<cmd>TmuxNavigateLeft<CR>]], nmap)
api.nvim_set_keymap("t", "<A-j>", [[<cmd>TmuxNavigateDown<CR>]], nmap)
api.nvim_set_keymap("t", "<A-k>", [[<cmd>TmuxNavigateUp<CR>]], nmap)
api.nvim_set_keymap("t", "<A-l>", [[<cmd>TmuxNavigateRight<CR>]], nmap)

-- helper functions
local qf_list_toggle = function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd("cclose")
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd("copen")
  end
end

local qf_list_clear = function()
  vim.fn.setqflist({})
end

local trim_whitespace = function()
  require("mini.trailspace").trim()
end

-- osc52 copy
local has_osc52, osc52 = pcall(require, "osc52")
if has_osc52 then
  local function copy(lines, _)
    osc52.copy(table.concat(lines, "\n"))
  end

  local function paste()
    return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
  end

  vim.g.clipboard = {
    name = "osc52",
    copy = { ["+"] = copy, ["*"] = copy },
    paste = { ["+"] = paste, ["*"] = paste },
  }
end

local has_wk, wk = pcall(require, "which-key")
if not has_wk then
  return
end
wk.register({
  name = "Actions",
  q = { qf_list_toggle, "Quickfix toggle" },
  Q = { qf_list_clear, "Quickfix clear" },
  s = { "<Cmd>update<CR>", "Save changes" },
  S = { "<Cmd>SudaWrite<CR>", "Sudo write" },
  l = { "<Cmd>nohlsearch<CR>", "No search hl" },
  u = { "<Cmd>UndotreeToggle<CR>", "Undotree" },
  w = { trim_whitespace, "Trim whitespace" },
  y = { [["+y]], "Copy to clipboard" },
  Y = { [["+Y]], "Copy line to clipboard" },
  f = {
    name = "File Explorer",
    l = { "<cmd>NvimTreeFindFileToggle<CR>", "Locate File" },
  },
}, { prefix = "," })

wk.register({
  name = "Visual Actions",
  y = { [["+y]], "Copy to clipboard" },
}, { prefix = ",", mode = "v" })
