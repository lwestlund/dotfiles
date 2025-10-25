return {
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
    },
    keys = {
      {
        -- Open file browser with the path of the current buffer.
        '<leader>.',
        ':Telescope file_browser path=%:p:h select_buffer=true<CR>',
        desc = 'Find file',
      },
    },
  },
}
