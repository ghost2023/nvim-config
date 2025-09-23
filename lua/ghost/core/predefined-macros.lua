vim.api.nvim_create_augroup('MyMacros', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = 'MyMacros',
  pattern = { "javascript", "typescript", "javascriptreact", 'typescriptreact' },
  callback = function()
    vim.fn.setreg('l', "yoconsole.log('pa:jkla €kb, jkp")
  end
})
