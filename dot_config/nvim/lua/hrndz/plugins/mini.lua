local has_surround, surround = pcall(require, "mini.surround")

if not has_surround then
  return
end

surround.setup({})

local has_align, align = pcall(require, "mini.surround")

if not has_align then
  return
end

align.setup({})
