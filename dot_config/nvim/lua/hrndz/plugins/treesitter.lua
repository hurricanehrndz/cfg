local status_ok, ts_configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

ts_configs.setup({
  -- ensure_installed = [],
  ensure_installed = { "c", "lua", "rust", "bash", "python", "comment", "yaml" },
  indent = { enable = true },
  highlight = { enable = true, disable = { "nix" } },
  additional_vim_regex_highlighting = false,
  rainbow = { enable = true, disable = { "bash", "nix" } },
})
