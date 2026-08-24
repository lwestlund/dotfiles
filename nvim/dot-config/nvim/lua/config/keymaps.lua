-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>'", Snacks.picker.resume, { desc = "Resume last search" })

vim.keymap.set("i", "<C-a>", "<C-o>^", { desc = "Move cursor to start of line" })
vim.keymap.set("i", "<C-e>", "<End>", { desc = "Move cursor to end of line" })

-- Copy path of current file to clipboard
local function copy_path(opts)
  opts = opts or {}
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    vim.notify("Buffer has no file", vim.log.levels.WARN)
    return
  end
  path = vim.fs.normalize(path)
  if not opts.absolute then
    path = vim.fs.relpath(LazyVim.root.get(), path) or path
  end
  if opts.line then
    path = path .. ":" .. vim.fn.line(".")
  end
  vim.fn.setreg("+", path)
  vim.notify("Copied " .. path)
end

vim.keymap.set("n", "<leader>fy", function()
  copy_path()
end, { desc = "Copy relative path" })
vim.keymap.set("n", "<leader>fY", function()
  copy_path({ absolute = true })
end, { desc = "Copy absolute path" })
vim.keymap.set("n", "<leader>fl", function()
  copy_path({ line = true })
end, { desc = "Copy relative path with line" })

-- Tab switching keymaps
for i = 1, 9 do
  vim.keymap.set("n", "<M-" .. i .. ">", i .. "gt", { desc = "Switch to tab " .. i })
end
