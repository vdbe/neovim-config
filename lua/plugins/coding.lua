return {
  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      -- local has_words_before = function()
      --   unpack = unpack or table.unpack
      --   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      --   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      -- end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<C-n>"] = function()
          if cmp.visible() then
            cmp.select_next_item(cmp_select)
          else
            cmp.complete()
          end
        end,
        ["<C-p>"] = function()
          if cmp.visible() then
            cmp.select_prev_item(cmp_select)
          else
            cmp.complete()
          end
        end,
        ["<C-Space>"] = function()
          if cmp.visible() then
            cmp.confirm({ select = true })
          else
            cmp.complete()
          end
        end,
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() and not cmp.get_selected_entry().exact then
            cmp.confirm({ select = true })
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
            -- elseif has_words_before() then -- Prevents normal tab when cursor not on whitepsace
            --   cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    optional = true,
    config = function(_, _)
      vim.api.nvim_create_autocmd({ "CursorHold" }, {
        callback = function()
          local luasnip = require("luasnip")
          if luasnip.expand_or_jumpable() then
            -- ask maintainer for option to make this silent
            -- luasnip.unlink_current()
            vim.cmd([[silent! lua require("luasnip").unlink_current()]])
          end
        end,
      })
    end,
  },

  -- Autocompletion for cmdline
  {
    "hrsh7th/cmp-cmdline",
    event = "CmdlineEnter",
    version = false, -- last release is way too old
    dependencies = { "hrsh7th/nvim-cmp" },
    lazy = true,
    opts = {},
    config = function(_, _)
      local cmp = require("cmp")

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        completion = {
          completeopt = "menu,menuone,noinsert,noselect",
        },
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          {
            name = "buffer",
            -- options = { get_bufnrs = get_bufnrs_visible },
          },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        completion = {
          completeopt = "menu,menuone,noinsert,noselect",
        },
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
          {
            name = "buffer",
            -- options = { get_bufnrs = get_bufnrs_visible },
          },
        }),
      })
    end,
  },

  -- Auto pairs
  {
    "echasnovski/mini.pairs",
    event = function(_, _)
      return "LazyFile"
    end,
  },

  -- Comments
  {
    "echasnovski/mini.comment",
    event = function(_, _)
      return "LazyFile"
    end,
  },

  -- Better text-objects
  {
    "echasnovski/mini.ai",
    event = function(_, _)
      return "LazyFile"
    end,
  },
}
