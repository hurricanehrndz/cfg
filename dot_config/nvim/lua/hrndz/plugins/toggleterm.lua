local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

-- Set git editor in toggleterm
vim.env.GIT_EDITOR = "nvr --remote-tab-wait +'set bufhidden=wipe'"

toggleterm.setup({
  open_mapping = nil,
  hide_numbers = true,
  direction = "float",
  start_in_insert = true,
  -- can not persist, if I want to always start in insert
  persist_mode = false,
})


local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  count = 99,
  hidden = true,
  direction = "float",
  insert_mappings = false,
  close_on_exit = true,
  persist_mode = false,
  start_in_insert = true,
})

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

local opts = { noremap = true, silent = true }
local lg_toggle = [[<cmd>lua _LAZYGIT_TOGGLE()<CR>]]
local lg_term_toggle = [[<C-\><C-n>]] .. lg_toggle
vim.keymap.set("n", "<C-g>", lg_toggle, opts)
vim.keymap.set("t", "<C-g>", lg_term_toggle, opts)

local term_open_group = vim.api.nvim_create_augroup("HrndzTermOpen", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = { "term://*" },
  callback = function()
    local bufopts = { buffer = 0, noremap = true, silent = true }
    vim.keymap.set("t", "<M-/>", [[<C-\><C-n>]], bufopts)
    vim.keymap.set("t", "<M-h>", [[<C-\><C-n><C-W>h]], bufopts)
    vim.keymap.set("t", "<M-j>", [[<C-\><C-n><C-W>j]], bufopts)
    vim.keymap.set("t", "<M-k>", [[<C-\><C-n><C-W>k]], bufopts)
    vim.keymap.set("t", "<M-l>", [[<C-\><C-n><C-W>l]], bufopts)
  end,
  group = term_open_group,
})

for i = 1, 5 do
  local keymap = string.format("<M-%s>", i)
  local normal_action = string.format([[<cmd>lua require('toggleterm').toggle(%s)<CR>]], i)
  local term_action = [[<C-\><C-n>]] .. normal_action
  vim.keymap.set("n", keymap, normal_action, opts)
  vim.keymap.set("t", keymap, term_action, opts)
end
