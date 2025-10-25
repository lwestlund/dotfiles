local fileops = require 'fileops'

return {
  {
    dir = vim.fn.stdpath 'config' .. '/lua/fileops',
    name = 'fileops',
    keys = {
      {
        '<leader>fD',
        fileops.delete_current_file,
        desc = 'Delete this file',
      },
    },
  },
}
