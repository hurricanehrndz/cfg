local has_npairs, npairs = pcall(require, "nvim-autopairs")

if not has_npairs then
  return
end

npairs.setup({
  fast_wrap = {},
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
