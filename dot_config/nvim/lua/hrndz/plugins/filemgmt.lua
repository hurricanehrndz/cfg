local has_ntree, ntree = pcall(require, "nvim-tree")
if not has_ntree then
  return
end

ntree.setup({})
