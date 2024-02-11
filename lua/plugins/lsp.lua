return {
  -- LSP config
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        update_in_insert = true,
        virtual_text = {
          prefix = "icons",
        },
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = true,
      },
    },
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()

    -- stylua: ignore
      keys[#keys + 1] = { "<leader>a", function() require("actions-preview").code_actions() end, desc = "Code Action", mode = { "n", "v" }, has = "codeAction", }
    end,
  },

  -- Diagnostics in virutal lines
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    lazy = true,
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        opts = {
          diagnostics = {
            ---@type boolean|OptsVirtualLines
            virtual_lines = false,
          },
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>ud", function() require("util.toggle").diagnostic_lines() end, desc = "Toggle Diagnostics Lines", },
      { "<leader>l", function() require("util.toggle").diagnostic_lines_only_current() end, desc = "Toggle Diagnostics Current line", },
    },
    opts = {
      ---@type OptsVirtualLines
      virtual_lines = {
        only_current_line = false,
        highlight_whole_line = true,
      },
    },
    config = true,
  },

  {
    "aznhe21/actions-preview.nvim",
    lazy = true,
    opts = {
      telescope = {
        sorting_strategy = "ascending",
        layout_strategy = "vertical",
        layout_config = {
          width = 0.8,
          height = 0.9,
          prompt_position = "top",
          preview_cutoff = 20,
          preview_height = function(_, _, max_lines)
            return max_lines - 15
          end,
        },
      },
    },
  },
}
