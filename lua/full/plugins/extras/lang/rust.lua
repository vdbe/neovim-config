return {
  -- step backadd rust to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "rust", "toml" })
      end
    end,
  },

  -- correctly setup mason lsp / dap extensions
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "codelldb", "rust-analyzer", "taplo" })
    end,
  },

  -- extend auto completion
  {
    "Saecki/crates.nvim",
    event = { "BufEnter Cargo.toml" },
    dependencies = {
      {
        "hrsh7th/nvim-cmp",
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts)
          local cmp = require("cmp")
          opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
            { name = "crates" },
          }))
        end,
        config = true,
      },
      {
        "neovim/nvim-lspconfig",
        opts = {
          setup = {
            taplo = function(_, opts)
              local function show_documentation()
                if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
                  require("crates").show_popup()
                else
                  vim.lsp.buf.hover()
                end
              end

              require("full.util").on_attach(function(client, buffer)
                if client.name == "taplo" then
                  vim.keymap.set("n", "<c-k>", show_documentation, { buffer = buffer })
                end
              end)
              return false -- make sure the base implementation calls taplo.setup
            end,
          },
        },
      },
    },
    config = true,
  },

  ---- correctly setup lspconfig
  {
    "simrat39/rust-tools.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim",
    },
    ft = "rust",
    opts = {
      dap = {
        --adapter = {},
      },
      tools = {
        hover_actions = {
          auto_focus = true,
          border = "none",
        },
        inlay_hints = {
          auto = true,
          show_parameter_hints = true,
        },
      },
      server = {
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              features = "all",
            },
            -- Add clippy lints for Rust.
            checkOnSave = true,
            check = {
              command = "clippy",
              features = "all",
            },
            procMacro = {
              enable = true,
            },
          },
        },
      },
    },
    config = function(_, opts)
      require("full.util").on_attach(function(client, buffer)
        if client.name == "rust_analyzer" then
          vim.keymap.set("n", "K", "<CMD>RustHoverActions<CR>", { buffer = buffer })
        end
      end)

      -- TODO: Put this in `opts`
      local adapter = require("dap").adapters.lldb
      if adapter == nil then
        local mason_registry = require("mason-registry")
        local codelldb = mason_registry.get_package("codelldb")
        local extension_path = codelldb:get_install_path() .. "/extension/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = vim.fn.has("mac") == 1 and extension_path .. "lldb/lib/liblldb.dylib"
          or extension_path .. "lldb/lib/liblldb.so"

        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
      end

      opts.dap.adapter = adapter

      require("rust-tools").setup(opts)
    end,
  },
}
