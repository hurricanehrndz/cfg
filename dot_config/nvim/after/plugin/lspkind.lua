local has_lspkind, lspkind = pcall(require, 'lspkind')
if not has_lspkind then
 do return end
end

lspkind.init()
