local has_surround, surround = pcall(require, "mini.surround")

if not has_surround then
  return
end

surround.setup({})
