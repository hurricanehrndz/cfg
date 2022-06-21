local ts_configs = require("nvim-treesitter.configs")

ts_configs.setup({
  -- ensure_installed = [],
  ensure_installed = { "c", "lua", "rust" },
  indent = { enable = true },
  highlight = { enable = true, disable = { "nix" } },
  additional_vim_regex_highlighting = false,
  rainbow = { enable = true, disable = { "bash", "nix" } },
})
