local util = require('lspconfig.util')

return {
  root_dir = function(fname)
    return util.root_pattern('.rubocop.yml')(fname)
  end,
  single_file_support = false,
}
