local null_ls = require("null-ls")
local b = null_ls.builtins
local sources = {
    b.formatting.prettier.with({
      disabled_filetypes = { "typescript", "typescriptreact" },
    }),
    b.formatting.shfmt.with({
      extra_args = { "-i", "2", "-ci" }
    }),
    b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),
    b.hover.dictionary,
}

local M = {}
M.setup = function (on_attach)
  local has_null_ls, _ = pcall(require, "null-ls")
  if not has_null_ls then
    return
  end
  null_ls.setup({
    sources = sources,
    on_attach = on_attach
  })
end

return M
