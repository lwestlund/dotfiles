local M = {}

-- --- Registers the keymapping with which-key.
-- -- This function is designed to be called from the user's config.
-- -- It sets up the keymap and registers it with which-key for visual feedback.
-- function M.setup()
--   vim.api.nvim_create_user_command('DeleteThisFile', function()
--     M.delete_current_file()
--   end, {
--     desc = 'Delete the current file and close its buffer after confirmation.',
--   })
-- end

--- Deletes the current file and its buffer after confirmation.
-- This function gets the full path of the current file, prompts the user
-- for confirmation, and if confirmed, deletes the file from disk and
-- closes the buffer.
function M.delete_current_file()
  -- Get the full, absolute path of the current file.
  -- expand('%:p') gets the path; '%'` is the current file, `:p` makes it a full path.
  local file_path = vim.fn.expand '%:p'

  -- Check if there's an actual file path to work with.
  if file_path == '' then
    vim.notify('Not a file buffer. Cannot delete.', vim.log.levels.WARN)
    return
  end

  -- Prompt the user for confirmation.
  local choice = vim.fn.confirm('Permanently delete ' .. vim.fn.fnamemodify(file_path, ':t') .. '?', '&Yes\n&No', 2)

  if choice ~= 1 then
    -- If the user chose "No" or closed the dialog.
    vim.notify('File deletion canceled.', vim.log.levels.INFO)
    return
  end

  if vim.fn.delete(file_path) == 0 then
    -- Close the buffer forcefully. The '!' adds the forceful part,
    -- preventing prompts about unsaved changes, since the file is now gone.
    vim.cmd 'bdelete!'
  else
    vim.notify('Failed to delete file: ' .. file_path, vim.log.levels.ERROR)
  end
end

return M
