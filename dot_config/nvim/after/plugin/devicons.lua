local has_devicons, devicons = pcall(require, 'nvim-web-devicons')
if not has_devicons then
 do return end
end

devicons.setup({default = true})
