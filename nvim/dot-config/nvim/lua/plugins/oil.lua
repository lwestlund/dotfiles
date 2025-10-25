return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup {
      -- This setting makes it so oil opens in the current window,
      -- rather than a floating window.
      default_file_explorer = true,

      -- Set up keymaps for the oil buffer
      keymaps = {
        ['<CR>'] = 'actions.select',
        ['<C-s>'] = 'actions.select_vsplit',
        ['<C-h>'] = 'actions.select_split',
        -- ['<C-t>'] = 'actions.select_tab',
        ['<C-p>'] = 'actions.preview',
        ['-'] = 'actions.close',
        ['<C-l>'] = 'actions.refresh',
        ['<BS>'] = 'actions.parent',
        ['_'] = 'actions.open_cwd',
        ['`'] = 'actions.cd',
        -- ['~'] = 'actions.tcd',
        ['gs'] = 'actions.change_sort',
        ['gx'] = 'actions.open_external',
        ['g.'] = 'actions.toggle_hidden',
      },
    }

    -- This is the keymap to open oil in the current file's directory
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

    -- You can also add a backspace mapping specifically for oil buffers
    -- This would be done in an ftplugin or an autocommand for the 'oil' filetype.
  end,
}
