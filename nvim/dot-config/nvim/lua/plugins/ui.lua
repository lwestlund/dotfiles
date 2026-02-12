return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        globalstatus = false,
      },
      theme = "doom-one",
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(s)
              return string.sub(s, 1, 1)
            end,
          },
        },
        lualine_x = {},
        lualine_y = {
          require("snacks").profiler.status(),
          -- stylua: ignore
          {
            require("noice").api.status.command.get,
            cond = require("noice").api.status.command.has,
            color = function() return { fg = Snacks.util.color("Statement") } end,
          },
          -- stylua: ignore
          {
            require("noice").api.status.mode.get,
            cond = require("noice").api.status.mode.has,
            color = function() return { fg = Snacks.util.color("Constant") } end,
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = function() return { fg = Snacks.util.color("Debug") } end,
          },
          -- stylua: ignore
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function() return { fg = Snacks.util.color("Special") } end,
          },
          {
            "diff",
            symbols = {
              added = LazyVim.config.icons.git.added,
              modified = LazyVim.config.icons.git.modified,
              removed = LazyVim.config.icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_z = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    opts = {
      highlight = {
        -- Use non-greedy matching up to the first keyword of the line, and an optional match of a
        -- parenthesis after the keyword, with a non-greedy matching of the closing parenthesis.
        -- Inspired from https://github.com/folke/todo-comments.nvim/pull/255.
        pattern = [[.{-}<((KEYWORDS)%(\(.{-1,}\))?):]],
      },
      search = {
        pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]],
      },
    },
  },
}
