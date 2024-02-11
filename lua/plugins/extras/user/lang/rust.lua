return {
  -- Ensure that rust-tools is not enabled
  { "simrat39/rust-tools.nvim", enabled = false },

  -- Add Rust & related to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ron", "rust", "toml" })
      end
    end,
  },

  -- Ensure Rust debugger is installed
  {
    "williamboman/mason.nvim",
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "codelldb" })
      end
    end,
  },

  -- Extend auto completion/lsp
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      src = {
        cmp = { enabled = true },
      },
    },
    config = function(_, opts)
      -- stylua: ignore
      local function keymaps(buffer)
          local crates = require("crates")

          vim.keymap.set("n", "<leader>ct", crates.toggle, { desc = "Crates Toggle", buffer = buffer, silent = true })
          vim.keymap.set("n", "<leader>cr", crates.reload, { desc = "Crates Reload", buffer = buffer, silent = true })

          vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, { desc = "Crates Version", buffer = buffer, silent = true })
          vim.keymap.set("n", "<leader>cf", crates.show_features_popup, { desc = "Crates Features", buffer = buffer, silent = true })
          vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, { desc = "Creates Dependencies", buffer = buffer, silent = true })

          vim.keymap.set("n", "<leader>cu", crates.update_crate, { desc = "Update Crate", buffer = buffer, silent = true })
          vim.keymap.set("v", "<leader>cu", crates.update_crates, { desc = "Update Crate(s)", buffer = buffer, silent = true })
          vim.keymap.set("n", "<leader>ca", crates.update_all_crates, { desc = "Update All Crates", buffer = buffer, silent = true })

          vim.keymap.set("n", "<leader>cx", crates.expand_plain_crate_to_inline_table, { desc = "Crate Expand inline", buffer = buffer, silent = true })
          vim.keymap.set("n", "<leader>cX", crates.extract_crate_into_table, { desc = "Crate Expaned", buffer = buffer, silent = true })

          vim.keymap.set("n", "<leader>cH", crates.open_homepage, { desc = "Crate open Homepage", buffer = buffer, silent = true })
          vim.keymap.set("n", "<leader>cR", crates.open_repository, { desc = "Crate open Repository", buffer = buffer, silent = true })
          vim.keymap.set("n", "<leader>cD", crates.open_documentation, { desc = "Crate open Documentation", buffer = buffer, silent = true })
          vim.keymap.set("n", "<leader>cC", crates.open_crates_io, { desc = "Crate open Crates.io", buffer = buffer, silent = true })
      end

      require("lazyvim.util").on_load("nvim-cmp", function()
        local cmp_opts = require("lazyvim.util").opts("nvim-cmp")

        local cmp = require("cmp")
        cmp_opts.sources = cmp.config.sources(vim.list_extend(cmp_opts.sources, {
          { name = "crates" },
        }))
      end)

      vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup("CargoKeymaps", {}),
        desc = "Crates keymaps",
        pattern = "Cargo.toml",
        callback = function(event)
          keymaps(event.buf)
        end,
      })

      require("crates").setup(opts)
      keymaps(0)
    end,
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
    command = "RustLsp",
    opts = {
      tools = {
        on_initialized = function()
          if require("lazyvim.util").has("nvim-dap") then
            require("lazyvim.util").on_load("nvim-dap", function()
              require("rustaceanvim.commands.debuggables").add_dap_debuggables()
            end)
          end

          -- local group = vim.api.nvim_create_augroup("RustLSP", {})
          --
          -- vim.api.nvim_create_autocmd("CursorHold", {
          --   group = group,
          --   pattern = "*.rs",
          --   callback = vim.lsp.buf.document_highlight,
          -- })
          -- vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter" }, {
          --   group = group,
          --   pattern = "*.rs",
          --   callback = vim.lsp.buf.clear_references,
          -- })
          -- vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
          --   group = group,
          --   pattern = "*.rs",
          --   callback = vim.lsp.codelens.refresh,
          -- })
        end,
      },
      server = {
        -- on_attach = function(client, bufnr)
        -- end,
        settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            -- Add clippy lints for Rust.
            checkOnSave = {
              allFeatures = true,
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("force", {}, opts or {})
    end,
  },

  -- Correctly setup lspconfig for Rust 🚀
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        ["rust-analyzer"] = {
          keys = {
            { "<leader>a", "<cmd>RustLsp codeAction<CR>", desc = "Code Action2" },
            { "J", "<cmd>RustLsp joinLines<CR>", desc = "Join Lines" },
          },
        },
        taplo = {
          keys = {
            {
              "K",
              function()
                if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
                  require("crates").show_popup()
                else
                  vim.lsp.buf.hover()
                end
              end,
              desc = "Show Crate Documentation",
            },
          },
        },
      },
      setup = {
        rust_analyzer = function()
          return true
        end,
        ["rust-analyzer"] = function()
          return true
        end,
      },
    },
  },

  {
    "nvim-neotest/neotest",
    optional = true,
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}
      vim.list_extend(opts.adapters, {
        require("rustaceanvim.neotest"),
      })
    end,
  },
}
