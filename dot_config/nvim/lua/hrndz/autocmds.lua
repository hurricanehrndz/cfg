local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local help_files = augroup("HelpFiles", { clear = true })
autocmd("Filetype", {
  pattern = { "help" },
  callback = function()
    local bufopts = { buffer = 0, noremap = true, silent = true }
    local nvo = { "n", "v", "o" }
    vim.keymap.set(nvo, "<C-c>", [[<cmd>q<CR>]], bufopts)
    vim.keymap.set(nvo, "q", [[<cmd>q<CR>]], bufopts)
  end,
  group = help_files,
})

local spell_enabled_files = augroup("SpellingEnabledFiles", { clear = true })
autocmd("Filetype", {
  pattern = { "markdown", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en"
  end,
  group = spell_enabled_files,
})

local yank_group = augroup("HighlightYank", {})
autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

local note_frontmatter_group = augroup("NoteFrontmatter", {})
autocmd("BufWrite", {
  group = note_frontmatter_group,
  pattern = "*.md",
  callback = function()
    ---@diagnostic disable-next-line: param-type-mismatch
    local filename = tostring(vim.fn.expand("%:p:h", false, false))
    if filename:find("src/me/notes") then
      local view = vim.fn.winsaveview()
      local mod_time = os.date("%Y-%m-%dT%H:%M:%S%z")
      local search_and_replace = "%%s/%s/%s/g"
      vim.cmd(search_and_replace:format([[^\(lastmod:\).*$]], [[\1 ]] .. mod_time))
      vim.fn.winrestview(view)
    end
  end,
})
