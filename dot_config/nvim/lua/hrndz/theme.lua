vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd("syntax on")

local has_tokyonight, tokyonight = pcall(require, "tokyonight")
if has_tokyonight and vim.g.hrnd_theme == "tokyonight" then
  tokyonight.setup({
    style = "night",
    sidebars = { "qf", "vista_kind", "terminal", "packer" },
  })

  -- Load the colorscheme
  vim.cmd([[colorscheme tokyonight]])
end

local has_notify, notify = pcall(require, "notify")
if has_notify then
  vim.notify = notify
end
