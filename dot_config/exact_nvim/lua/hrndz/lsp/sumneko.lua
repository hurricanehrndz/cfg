local lspconfig = require("lspconfig")

local root_path = ""
local binary = ""

root_path = vim.fn.getenv("HOME") .. "/.cache/nvim/lua-language-server/"
binary = root_path .. "bin/lua-language-server"

local M = {}
M.setup = function(on_attach, capabilities)
  local has_luadev, luadev = pcall(require, "lua-dev")
  if not has_luadev then
    return
  end
  local luadev_config = luadev.setup({
    lspconfig = {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { binary },
      flags = {
        debounce_text_changes = 150,
      },
    },
  })
  lspconfig.sumneko_lua.setup(luadev_config)
end

return M
