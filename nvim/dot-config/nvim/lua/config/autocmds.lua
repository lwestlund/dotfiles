-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("BufDelete", {
  callback = function()
    vim.schedule(function()
      local bufs = vim.fn.getbufinfo({ buflisted = 1 })
      if #bufs == 0 or (#bufs == 1 and bufs[1].name == "" and bufs[1].changed == 0) then
        if _G.Snacks and Snacks.dashboard then
          Snacks.dashboard.open()
        end
      end
    end)
  end,
})