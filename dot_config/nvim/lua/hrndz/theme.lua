local fn = vim.fn

if fn['has']('termguicolors') then
  vim.o.termguicolors = true
end

vim.o.background = 'dark'
vim.cmd('syntax on')

local has_onedark, onedark = pcall(require, 'onedark')
if has_onedark and vim.g.hrnd_theme == 'onedark' then
  vim.g.onedark_disable_terminal_colors = true
  onedark.setup()
end

local has_gruvbox, _ = pcall(function() vim.fn['gruvbox_material#get_configuration']() end)
if has_gruvbox and vim.g.hrnd_theme == 'gruvbox' then
  vim.g.gruvbox_material_backgroud = 'hard'
  vim.g.gruvbox_material_enable_italic = 1
  vim.g.gruvbox_material_enable_bold = 1
  vim.cmd('colorscheme gruvbox-material')
end

-- neovim/neovim/issues/11335
if (fn['has']('termguicolors') and fn['has']('nvim-0.5.0') and vim.api.nvim_list_uis()[1]['ext_termcolors']) then
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
end
vim.cmd("hi Floaterm guibg=#21252b")
