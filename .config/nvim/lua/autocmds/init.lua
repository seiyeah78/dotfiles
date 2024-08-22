vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format() end, {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(args)
    local client_id = args.data.client_id
    local client = vim.lsp.get_client_by_id(client_id)
    if client == nil then
      return
    end
    if client.supports_method("textDocument/formatting") and client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        callback = function()
          if vim.api.nvim_buf_get_option(args.buf, 'filetype') == "gitcommit" then
            return
          end
          vim.lsp.buf.format({ id = client_id, timeout = 2000 })
        end,
      })
    end
  end
})
