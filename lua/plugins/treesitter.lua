return {
  -- Treesitter is a new parser generator tool that we can
  -- use in Neovim to power faster and more accurate
  -- syntax highlighting.
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = {
      textobjects = {
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]?"] = { query = "@conditional.inner", desc = "Next conditional start" },
            ["]a"] = { query = "@parameter.inner", desc = "Next argument start" },
            -- ["]c"] = { query = "@class.outer", desc = "Next class start" },
            -- ["]f"] = { query = "@function.outer", desc = "Next function start" },
            ["]k"] = { query = "@block.outer", desc = "Next block start" },
            ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
            ["]m"] = { query = "@function.outer", desc = "Next method start" },
            ["]n"] = { query = "@number.inner", desc = "Next number start" },
            ["]r"] = { query = "@return.outer", desc = "Next return start" },
          },
          goto_next_end = {
            ["]A"] = { query = "@parameter.inner", desc = "Next argument end" },
            -- ["]C"] = { query = "@class.outer", desc = "Next class end" },
            -- ["]F"] = { query = "@function.outer", desc = "Next function end" },
            ["]K"] = { query = "@block.outer", desc = "Next block end" },
            ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
            ["]M"] = { query = "@function.outer", desc = "Next method end" },
            ["]N"] = { query = "@number.inner", desc = "Next number end" },
            ["]R"] = { query = "@return.outer", desc = "Next return end" },
          },
          goto_previous_start = {
            ["[?"] = { query = "@conditional.inner", desc = "Previous conditional start" },
            ["[a"] = { query = "@parameter.inner", desc = "Previous argument start" },
            -- ["[c"] = { query = "@class.outer", desc = "Previous class start" },
            -- ["[f"] = { query = "@function.outer", desc = "Previous function start" },
            ["[k"] = { query = "@block.outer", desc = "Previous block start" },
            ["[l"] = { query = "@loop.outer", desc = "Previous loop start" },
            ["[m"] = { query = "@function.outer", desc = "Previous method start" },
            ["[n"] = { query = "@number.inner", desc = "Previous number start" },
            ["[r"] = { query = "@return.outer", desc = "Previous return start" },
          },
          goto_previous_end = {
            ["[A"] = { query = "@parameter.inner", desc = "Previous argument end" },
            -- ["[C"] = { query = "@class.outer", desc = "Previous class end" },
            -- ["[F"] = { query = "@function.outer", desc = "Previous function end" },
            ["[K"] = { query = "@block.outer", desc = "Previous block end" },
            ["[L"] = { query = "@loop.outer", desc = "Previous loop end" },
            ["[M"] = { query = "@function.outer", desc = "Previous method end" },
            ["[N"] = { query = "@number.inner", desc = "Previous number end" },
            ["[R"] = { query = "@return.outer", desc = "Previous return end" },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>>k"] = { query = "@block.outer", desc = "Swap next block" },
            ["<leader>>m"] = { query = "@function.outer", desc = "Swap next method" },
            ["<Leader>sf"] = { query = "@function.outer", desc = "Swap next function" },
            ["<leader>>a"] = { query = "@parameter.inner", desc = "Swap next argument" },
            ["<leader>>n"] = { query = "@number.inner", desc = "Swap next number" },
            ["<leader>>?"] = { query = "@conditional.inner", desc = "Swap next conditional" },
            ["<leader>>r"] = { query = "@return.outer", desc = "Swap next return" },
          },
          swap_previous = {
            ["<leader><k"] = { query = "@block.outer", desc = "Swap previous block" },
            ["<leader><m"] = { query = "@function.outer", desc = "Swap previous method" },
            ["<Leader><f"] = { query = "@function.outer", desc = "Swap previous function" },
            ["<leader><a"] = { query = "@parameter.inner", desc = "Swap previous argument" },
            ["<leader><n"] = { query = "@number.inner", desc = "Swap previous number" },
            ["<leader><?"] = { query = "@conditional.inner", desc = "Swap previous conditional" },
            ["<leader><r"] = { query = "@return.outer", desc = "Swap previous return" },
          },
        },
      },
    },
  },
}
