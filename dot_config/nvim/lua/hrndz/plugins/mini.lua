---@diagnostic disable-next-line: missing-parameter
local has_mini, misc = pcall(require, "mini.misc")
if not has_mini then
  return
end

misc.setup({})
require("mini.ai").setup({})
require("mini.align").setup({})
require("mini.jump").setup({})
require("mini.surround").setup({})
require("mini.trailspace").setup({})
