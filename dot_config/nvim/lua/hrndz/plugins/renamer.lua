local has_renamer, renamer = pcall(require, "renamer")
if not has_renamer then
  return
end

renamer.setup()
