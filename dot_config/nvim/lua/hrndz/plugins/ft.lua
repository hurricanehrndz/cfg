local has_ft, ft = pcall(require, "filetype")

if not has_ft then
  return
end

ft.setup({
  overrides = {
    extensions = {
      -- Set pp files to puppet
      pp = "puppet",
    },
  },
})
