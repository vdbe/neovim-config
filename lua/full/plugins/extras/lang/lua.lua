return {
  -- add python to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    ft = "lua",
    module = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "lua" })
      end
    end,
  },

  -- correctly setup mason lsp / debug extensions
  {
    "williamboman/mason.nvim",
    ft = "lua",
    module = true,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "lua-language-server",
      })
    end,
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = "lua",
    module = true,
    dependencies = { "mason.nvim" },
    opts = function(_, opts)
      local nls = require("null-ls")
      vim.list_extend(opts.sources, {
        nls.builtins.formatting.stylua,
      })
    end,
  },

  --- lsp
  {
    "neovim/nvim-lspconfig",
    ft = "lua",
    module = true,
    dependencies = { "mason.nvim" },
    ---@class PluginLspOpts
    opts = {
      servers = {
        lua_ls = {
          mason = false, -- set to false if you don't want this server to be installed with mason
          settings = {
            Lua = {
              runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
              },
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
              },
              workspace = {
                checkThirdParty = false,
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
              },
              completion = {
                callSnippet = "Replace",
              },
              -- Do not send telemetry data containing a randomized but unique identifier
              telemetry = {
                enable = false,
              },
            },
          },
        },
      },
    },
  },
}
