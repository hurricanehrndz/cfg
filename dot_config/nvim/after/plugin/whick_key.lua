local has_whichkey, which_key = pcall(require, 'which-key')
if has_whichkey then
  which_key.setup()
end
