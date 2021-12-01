local eslint_opts = {
  condition = function(utils)
    return utils.root_has_file(".eslintrc.js")
  end,
  diagnostics_format = "#{m} [#{c}]",
}

local has_null_ls, null_ls = pcall(require, 'null-ls')
if not has_null_ls then
  return
end

local b = null_ls.builtins
local sources = {
    b.formatting.prettier.with({
        disabled_filetypes = { "typescript", "typescriptreact" },
    }),
    b.diagnostics.eslint_d.with(eslint_opts),
    b.formatting.eslint_d.with(eslint_opts),
    b.code_actions.eslint_d.with(eslint_opts),
    b.formatting.shfmt,
    b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),
    b.hover.dictionary,
}

local M = {}
M.setup = function(on_attach)
  null_ls.config({
    sources = sources,
  })
  null_ls.setup({ on_attach = on_attach })
end

return M
