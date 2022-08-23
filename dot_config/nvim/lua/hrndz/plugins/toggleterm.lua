require("toggleterm").setup({
  open_mapping = nil,
  hide_numbers = true,
  direction = "float",
  size = 15,
  start_in_insert = true,
})

vim.env.GIT_EDITOR = "nvr --remote-tab-wait +'set bufhidden=wipe'"

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
local term_open_group = vim.api.nvim_create_augroup("HrndzTermOpen", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = { "term://*" },
  callback = function()
    local opts = { buffer = 0, noremap = true, silent = true }
    vim.keymap.set("t", "<M-/>", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "<M-h>", [[<C-\><C-n><C-W>h]], opts)
    vim.keymap.set("t", "<M-j>", [[<C-\><C-n><C-W>j]], opts)
    vim.keymap.set("t", "<M-k>", [[<C-\><C-n><C-W>k]], opts)
    vim.keymap.set("t", "<M-l>", [[<C-\><C-n><C-W>l]], opts)
  end,
  group = term_open_group,
})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  count = 99,
  hidden = true,
  direction = "float",
  close_on_exit = true,
  on_open = function(term)
    vim.cmd("startinsert!")
    local opts = { noremap = true, silent = true, buffer = term.bufnr }
    vim.keymap.set("n", "q", "<cmd>close<CR>", opts)
  end,
})

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<C-g>", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)
for i=1,7 do
  vim.keymap.set("n", "<M-" .. i .. ">", "<cmd>" .. i .."ToggleTerm<CR>", opts)
  vim.keymap.set("t", "<M-" .. i .. ">", "<cmd>" .. i .."ToggleTerm<CR>", opts)
end
