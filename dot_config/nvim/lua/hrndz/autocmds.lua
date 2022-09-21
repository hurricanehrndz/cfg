local api = vim.api

local help_files = api.nvim_create_augroup("HelpFiles", { clear = true })
api.nvim_create_autocmd("Filetype", {
  pattern = { "help" },
  callback = function()
    local bufopts = { buffer = 0, noremap = true, silent = true }
    local nvo = { "n", "v", "o" }
    vim.keymap.set(nvo, "<C-c>", [[<cmd>q<CR>]], bufopts)
    vim.keymap.set(nvo, "q", [[<cmd>q<CR>]], bufopts)
  end,
  group = help_files,
})

local spell_enabled_files = api.nvim_create_augroup("SpellingEnabledFiles", { clear = true })
api.nvim_create_autocmd("Filetype", {
  pattern = { "markdown", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en"
  end,
  group = spell_enabled_files,
})
