-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>'", Snacks.picker.resume, { desc = "Resume last search" })

vim.keymap.set("i", "<C-a>", "<C-o>^", { desc = "Move cursor to start of line" })
vim.keymap.set("i", "<C-e>", "<End>", { desc = "Move cursor to end of line" })
