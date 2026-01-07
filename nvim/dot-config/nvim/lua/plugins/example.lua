if true then
  return {
    { "akinsho/bufferline.nvim", enabled = false },
    { "nvim-mini/mini.pairs", enabled = false },
    {
      "folke/snacks.nvim",
      opts = {
        indent = { enabled = false },
        scroll = { enabled = false },
      },
    },

    {
      "stevearc/conform.nvim",
      opts = {
        formatters = {
          sqlfluff = {
            args = { "format", "-" },
          },
        },
      },
    },

    {
      "nvim-lualine/lualine.nvim",
      opts = {
        sections = {
          lualine_x = {},
          lualine_y = {
            require("snacks").profiler.status(),
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = function() return { fg = Snacks.util.color("Statement") } end,
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
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
      "mfussenegger/nvim-lint",
      opts = {
        linters = {
          sqlfluff = {
            args = {
              "lint",
              "--format=json",
            },
          },
        },
      },
    },

    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function(_)
        local npairs = require("nvim-autopairs")
        npairs.setup({})

        local Rule = require("nvim-autopairs.rule")
        local cond = require("nvim-autopairs.conds")

        local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
        npairs.add_rules({
          -- Rule for a pair with left-side ' ' and right side ' '
          Rule(" ", " ")
            -- Pair will only occur if the conditional function returns true
            :with_pair(function(opts)
              -- We are checking if we are inserting a space in (), [], or {}
              local pair = opts.line:sub(opts.col - 1, opts.col)
              return vim.tbl_contains({
                brackets[1][1] .. brackets[1][2],
                brackets[2][1] .. brackets[2][2],
                brackets[3][1] .. brackets[3][2],
              }, pair)
            end)
            :with_move(cond.none())
            :with_cr(cond.none())
            -- We only want to delete the pair of spaces when the cursor is as such: ( | )
            :with_del(
              function(opts)
                local col = vim.api.nvim_win_get_cursor(0)[2]
                local context = opts.line:sub(col - 1, col + 2)
                return vim.tbl_contains({
                  brackets[1][1] .. "  " .. brackets[1][2],
                  brackets[2][1] .. "  " .. brackets[2][2],
                  brackets[3][1] .. "  " .. brackets[3][2],
                }, context)
              end
            ),
        })
        -- For each pair of brackets we will add another rule
        for _, bracket in pairs(brackets) do
          npairs.add_rules({
            -- Each of these rules is for a pair with left-side '( ' and right-side ' )' for each bracket type
            Rule(bracket[1] .. " ", " " .. bracket[2])
              :with_pair(cond.none())
              :with_move(function(opts)
                return opts.char == bracket[2]
              end)
              :with_del(cond.none())
              :use_key(bracket[2])
              -- Removes the trailing whitespace that can occur without this
              :replace_map_cr(function(_)
                return "<C-c>2xi<CR><C-c>O"
              end),
          })
        end
      end,
      -- use opts = {} for passing setup options
      -- this is equivalent to setup({}) function
    },

    {
      "NeogitOrg/neogit",
      dependencies = {
        "nvim-lua/plenary.nvim", -- required
        "sindrets/diffview.nvim", -- optional - Diff integration

        -- Only one of these is needed.
        -- "nvim-telescope/telescope.nvim", -- optional
        -- "ibhagwan/fzf-lua",              -- optional
        -- "nvim-mini/mini.pick",           -- optional
        "folke/snacks.nvim", -- optional
        "https://github.com/isakbm/gitgraph.nvim",
      },
      keys = {
        {
          "<leader>gg",
          function()
            require("neogit").open()
          end,
          desc = "Neogit status",
        },
      },
      opts = {
        graph_style = "kitty",
        remember_settings = false,
        kind = "replace",
        commit_editor = {
          kind = "auto",
        },
        mappings = {
          popup = {
            ["p"] = "PushPopup",
            ["P"] = false,
            ["F"] = "PullPopup",
          },
          status = {
            ["["] = "GoToPreviousHunkHeader",
            ["]"] = "GoToNextHunkHeader",
          },
        },
      },
    },

    {
      "max397574/better-escape.nvim",
      config = function()
        require("better_escape").setup()
      end,
    },

    -- Color scheme.
    {
      "navarasu/onedark.nvim",
      opts = {
        style = "dark",
        colors = {
          blue = "#51afef",
          green = "#98be65",
          bright_violet = "#C59DD3",
          violet = "#a9a1e1",
          orange = "#da8548",
          orange2 = "#d19a66",

          -- black = "#181a1f",
          -- bg0 = "#282c34",
          -- bg1 = "#31353f",
          -- bg2 = "#393f4a",
          -- bg3 = "#3b3f4c",
          -- bg_d = "#21252b",
          -- bg_blue = "#73b8f1",
          -- bg_yellow = "#ebd09c",
          -- fg = "#abb2bf",
          -- purple = "#c678dd",
          -- green = "#98c379",
          -- orange = "#d19a66",
          -- blue = "#61afef",
          -- yellow = "#e5c07b",
          -- cyan = "#56b6c2",
          -- red = "#e86671",
          -- grey = "#5c6370",
          -- light_grey = "#848b98",
          -- dark_cyan = "#2b6f77",
          -- dark_red = "#993939",
          -- dark_yellow = "#93691d",
          -- dark_purple = "#8a3fa0",
          -- diff_add = "#31392b",
          -- diff_delete = "#382b2c",
          -- diff_change = "#1c3448",
          -- diff_text = "#2c5372",
        },
        highlights = {
          ["@constructor"] = { fg = "$blue" },
          ["@function"] = { fg = "$purple" },
          ["@function.call"] = { fg = "$purple" },
          ["@keyword"] = { fg = "$blue" },
          ["@keyword.function"] = { fg = "$blue" },
          ["@keyword.import"] = { fg = "$blue" },
          ["@keyword.return"] = { fg = "$blue" },
          ["@module"] = { fg = "$purple" },
          ["@lsp.mod.attribute"] = { fg = "$blue" },
          ["@lsp.type.function"] = { fg = "$purple" },
          ["@lsp.type.namespace"] = { fg = "$violet" },
          ["@lsp.type.property"] = { fg = "$purple" },
          ["@lsp.type.variable"] = { fg = "$bright_violet" },
          ["@lsp.type.parameter"] = { fg = "$bright_violet" },
          ["@property"] = { fg = "$purple" },
          ["@property.toml"] = { fg = "$yellow" },
          ["MatchParen"] = { fg = "$red", bg = "none" },
          -- vim-illuminate
          ["IlluminatedWordWrite"] = { bg = "$diff_text" },
          ["IlluminatedWordRead"] = { bg = "$dark_cyan" },
          -- neogit
          ["NeogitSectionHeader"] = { fg = "$blue" },
          ["NeogitBranch"] = { fg = "$cyan" },
          ["NeogitBranchHead"] = { fg = "$cyan" },
          ["NeogitChangeDeleted"] = { fg = "$red" },
          ["NeogitChangeModified"] = { fg = "$fg" },
          ["NeogitPopupSwitchEnabled"] = { fg = "$green" },
          -- snacks
          ["SnacksDashboardHeader"] = { fg = "$blue" },
          ["SnacksDashboardFooter"] = { fg = "$bg_blue" },
          ["SnacksDashboardSpecial"] = { fg = "$bg_blue" },
        },
      },
    },
    {
      "kylechui/nvim-surround",
      version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
        require("nvim-surround").setup({
          keymaps = {
            normal = "gsa",
            visual = "gS",
            delete = "gsd",
            change = "gsc",
          },
        })
      end,
    },
    {
      "lwestlund/doom-one.nvim",
      dir = "~/git/doom-one.nvim/",
      config = function()
        -- vim.api.nvim_set_hl(0, gcc, val)
        -- Add color to cursor
        vim.g.doom_one_cursor_coloring = false
        -- Set :terminal colors
        vim.g.doom_one_terminal_colors = true
        -- Enable italic comments
        vim.g.doom_one_italic_comments = false
        -- Enable TS support
        vim.g.doom_one_enable_treesitter = true
        -- Color whole diagnostic text or only underline
        vim.g.doom_one_diagnostics_text_color = false
        -- Enable transparent background
        vim.g.doom_one_transparent_background = false

        -- Pumblend transparency
        vim.g.doom_one_pumblend_enable = false
        vim.g.doom_one_pumblend_transparency = 20

        -- Plugins integration
        vim.g.doom_one_plugin_neorg = false
        vim.g.doom_one_plugin_barbar = false
        vim.g.doom_one_plugin_telescope = false
        vim.g.doom_one_plugin_neogit = true
        vim.g.doom_one_plugin_nvim_tree = false
        vim.g.doom_one_plugin_dashboard = false
        vim.g.doom_one_plugin_startify = false
        vim.g.doom_one_plugin_whichkey = false
        vim.g.doom_one_plugin_indent_blankline = false
        vim.g.doom_one_plugin_vim_illuminate = false
        vim.g.doom_one_plugin_lspsaga = false
      end,
    },
    { "LazyVim/LazyVim", opts = { colorscheme = "doom-one" } },

    {
      "folke/snacks.nvim",
      opts = {
        dashboard = {
          preset = {
            header = [[
                                                                    
       ████ ██████           █████      ██                    
      ███████████             █████                            
      █████████ ███████████████████ ███   ███████████  
     █████████  ███    █████████████ █████ ██████████████  
    █████████ ██████████ █████████ █████ █████ ████ █████  
  ███████████ ███    ███ █████████ █████ █████ ████ █████ 
 ██████  █████████████████████ ████ █████ █████ ████ ██████
 ]],
          },
        },
      },
    },
  }
end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  -- disable trouble
  { "folke/trouble.nvim", enabled = false },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },

  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },

  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return "😄"
        end,
      })
    end,
  },

  -- or you can return new options to override all the defaults
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        --[[add your custom lualine config here]]
      }
    end,
  },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },
}
