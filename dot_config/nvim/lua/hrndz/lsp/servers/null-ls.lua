local null_ls = require("null-ls")
local b = null_ls.builtins
local u = require("null-ls.utils")

local function match_conf(...)
  local patterns = ...
  local f = u.root_pattern(...)
  return function(root)
    local d = f(root)
    for _, pattern in ipairs(vim.tbl_flatten({ patterns })) do
      local c = string.format("%s/%s", d, pattern)
      if u.path.exists(c) then
        return c
      end
    end
  end
end

local sources = {
  -- formatting
  b.formatting.prettier.with({
    disabled_filetypes = { "typescript", "typescriptreact" },
    extra_args = { "--prose-wrap", "always" },
  }),
  -- google style
  b.formatting.shfmt.with({
    extra_args = { "-i", "2", "-ci", "-bn", "-o" },
  }),
  b.formatting.beautysh.with({
    filetypes = { "zsh" },
    extra_args = { "--indent-size", "2" },
  }),
  b.formatting.stylua,
  b.formatting.black.with({ extra_args = { "--fast" } }),
  b.formatting.cbfmt.with({
    extra_args = function(params)
      local c = match_conf(".cbfmt.toml")(params.root)
      if c then
        return { "--config", c }
      end
    end,
  }),

  -- diagnostics
  b.diagnostics.shellcheck.with({
    diagnostics_format = "#{m} [#{c}]",
    filetypes = { "sh", "zsh" },
    extra_args = { "-o", "require-double-brackets" },
  }),
  b.diagnostics.vale,
  b.diagnostics.markdownlint,
  b.diagnostics.flake8,

  -- hover
  b.hover.dictionary,
}

local M = {}
M.setup = function(on_attach)
  local has_null_ls, _ = pcall(require, "null-ls")
  if not has_null_ls then
    return
  end
  null_ls.setup({
    sources = sources,
    on_attach = on_attach,
  })
end

return M
