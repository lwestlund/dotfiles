-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.number = false
opt.relativenumber = false

opt.laststatus = 2

-- Custom tab line to show directory name
function _G.MyTabLine()
  local s = ""
  local total_tabs = vim.fn.tabpagenr("$")
  local current_tab = vim.fn.tabpagenr()

  for tab_idx = 1, total_tabs do
    -- Start with adding in the tab page number, this is to be able to change
    -- tabs with mouse clicks.
    s = s .. "%" .. tab_idx .. "T"

    -- Set highlights
    local hl = tab_idx == current_tab and "%#TabLineSel#" or "%#TabLine#"
    local num_hl = tab_idx == current_tab and "%#Special#" or "%#TabLine#"

    -- Get the tab-local working directory (or global if not set)
    -- We can get this by grabbing a window in that tab and checking its CWD
    local winnr = vim.fn.tabpagewinnr(tab_idx)
    local buflist = vim.fn.tabpagebuflist(tab_idx)
    local bufnr = buflist[winnr]
    local buftype = vim.fn.getbufvar(bufnr, "&buftype")
    local bufname = vim.api.nvim_buf_get_name(bufnr)

    local label
    if buftype == "" then
      -- Real buffer, use CWD
      local cwd = vim.fn.getcwd(winnr, tab_idx)
      label = vim.fn.fnamemodify(cwd, ":t")
    elseif bufname ~= "" then
      -- Special buffer, use buffer name
      label = vim.fn.fnamemodify(bufname, ":t")
    else
      -- Fallback
      label = "[No Name]"
    end

    -- Check if any buffer in this tab is modified
    local modified = ""
    for _, b in ipairs(buflist) do
      if vim.fn.getbufvar(b, "&modified") == 1 then
        modified = " [+]"
        break
      end
    end

    -- Set the tab label with distinct highlighting for the index
    s = s .. " " .. num_hl .. tab_idx .. " " .. hl .. label .. modified .. " "
  end

  -- Fill the rest, and reset the tab page number.
  s = s .. "%#TabLineFill#%T"
  return s
end

opt.tabline = "%!v:lua.MyTabLine()"
