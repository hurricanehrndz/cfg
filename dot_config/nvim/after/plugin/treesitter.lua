local has_ts_configs, ts_configs = pcall(require, 'nvim-treesitter.configs')
if not has_ts_configs then
 return
end

ts_configs.setup({
  ensure_installed = 'maintained',
  indent = { enable = true },
  highlight = {enable = true, disable = {'nix'}},
  additional_vim_regex_highlighting = false,
  rainbow = {enable = true, disable = {'bash', 'nix'}}
})
