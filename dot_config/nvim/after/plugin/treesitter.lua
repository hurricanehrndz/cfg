local has_ts, ts = pcall(require, 'nvim-treesitter')
if not has_ts then
 do return end
end

ts.setup({
  ensure_installed = 'maintained',
  highlight = {enable = true, disable = {'nix'}},
  rainbow = {enable = true, disable = {'bash', 'nix'}}
})
