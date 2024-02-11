return {
  {
    "LazyVim/LazyVim",
    optional = true,
    opts = {
      defaults = {
        keymaps = false,
      },
      news = {
        lazyvim = false,
      },
    },
  },

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = {
      close_if_last_window = true,
      window = {
        position = "right",
        mappings = {
          ["<tab>"] = {
            "toggle_node",
            nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to
          },
        },
      },
    },
  },

  -- Fuzzy finder.
  -- The default key bindings to find files will use Telescope's
  -- `find_files` or `git_files` depending on whether the
  -- directory is a git repo.
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function()
      local actions = require("telescope.actions")

      return {
        defaults = {
          mappings = {
            i = {
              ["jk"] = actions.close,
            },
            n = {
              ["q"] = actions.close,
            },
          },
        },
      }
    end,
  },

  -- git signs highlights text that has changed since the list
  -- git commit, and also lets you interactively stage & unstage
  -- hunks in a commit.
  {
    "lewis6991/gitsigns.nvim",
    optional = true,
    event = "LazyFile",
    opts = {
      current_line_blame_opts = {
        delay = 100,
      },
    },
  },

  {
    "m4xshen/hardtime.nvim",
    lazy = true,
    -- dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    version = false,
    event = "LazyFile",
    cmd = "Hardtime",
    priority = 10,
    opts = {
      disable_mouse = false,
      disabled_filetypes = {
        "help",
        "lazy",
        "netrw",
        "qf",
        "neotest-summary",
        "neo-tree",
      },
    },
    config = true,
  },
}
