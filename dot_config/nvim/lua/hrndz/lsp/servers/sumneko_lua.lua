local M = {}

M.setup = function(on_attach, capabilities)
  local lspconfig = require("lspconfig")
  local has_luadev, luadev = pcall(require, "lua-dev")
  if not has_luadev then
    return
  end
  local luadev_config = luadev.setup({
    lspconfig = {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150,
      },
    },
  })
  lspconfig.sumneko_lua.setup(luadev_config)
end

return M
