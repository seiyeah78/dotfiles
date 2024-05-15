vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format() end, {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(args)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = args.buf,
      callback = function()
        if vim.api.nvim_buf_get_option(args.buf, 'filetype') == "gitcommit" then
          return
        end
        vim.lsp.buf.format { async = false, id = args.data.client_id }
      end,
    })
  end
})
