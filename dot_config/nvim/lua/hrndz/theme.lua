local fn = vim.fn

if fn["has"]("termguicolors") then
  vim.o.termguicolors = true
end

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

-- neovim/neovim/issues/11335
--[[ if (fn['has']('termguicolors') and fn['has']('nvim-0.5.0') and vim.api.nvim_list_uis()[1]['ext_termcolors']) then
  vim.g.terminal_color_0 = nil
  vim.g.terminal_color_1 = nil
  vim.g.terminal_color_2 = nil
  vim.g.terminal_color_3 = nil
  vim.g.terminal_color_4 = nil
  vim.g.terminal_color_5 = nil
  vim.g.terminal_color_6 = nil
  vim.g.terminal_color_7 = nil
  vim.g.terminal_color_8 = nil
  vim.g.terminal_color_9 = nil
  vim.g.terminal_color_10 = nil
  vim.g.terminal_color_11 = nil
  vim.g.terminal_color_12 = nil
  vim.g.terminal_color_13 = nil
  vim.g.terminal_color_14 = nil
  vim.g.terminal_color_15 = nil
  vim.g.terminal_color_background = nil
  vim.g.terminal_color_foreground = nil
end ]]
--
