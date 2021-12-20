local has_colorizer, colorizer = pcall(require, 'colorizer')
if not has_colorizer then
 do return end
end

colorizer.setup()
