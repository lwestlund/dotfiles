return {
  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim", -- required

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
      kind = "tab",
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
        commit_editor = {
          ["gk"] = "PrevMessage",
          ["gj"] = "NextMessage",
        },
      },
    },
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gL", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview File History" },
    },
    opts = {
      keymaps = {
        view = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
        },
        file_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
        },
        file_history_panel = {
          { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
        },
      },
    },
  },
}
