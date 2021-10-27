local has_devicons, devicons = pcall(require, 'colorizer')
if not has_devicons then
 do return end
end

devicons.setup({default = true})
