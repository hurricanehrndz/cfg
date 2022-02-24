local ts_configs = require("nvim-treesitter.configs")

ts_configs.setup({
  ensure_installed = "maintained",
  indent = { enable = true },
  highlight = { enable = true, disable = { "nix" } },
  additional_vim_regex_highlighting = false,
  rainbow = { enable = true, disable = { "bash", "nix" } },
})