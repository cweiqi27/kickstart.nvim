-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    setup = function()
      local null_ls = require("null-ls")

      local sources = {
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.formatting.prettier.with({
          filetypes = { "html", "json", "yaml", "markdown", "typescriptreact", "typescript" },
        }),
        null_ls.builtins.code_actions.gitsigns,
      }

      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      null_ls.setup({
        sources = sources,
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                vim.lsp.buf.formatting_sync()
              end,
            })
          end
        end,

      })
    end,
    config = {
      requires = {
        "nvim-lua/plenary.nvim",
      },
    },
  },
  { "elkowar/yuck.vim",            enabled = true },
  { "MunifTanjim/nui.nvim",        enabled = true },
  { "nvim-tree/nvim-web-devicons", enabled = true },
  { "nvim-lua/plenary.nvim",       enabled = true },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            '.git',
          },
          never_show = {},
        },
      }
    }
  },
  {
    "edluffy/hologram.nvim",
    enabled = true,
    opts = {
      auto_display = true
    }
  },
  {
    's1n7ax/nvim-window-picker',
    config = function()
      require 'window-picker'.setup()
      vim.keymap.set("n", "<leader>W", function()
        local picked_window_id = vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(picked_window_id)
      end, { desc = "Pick a window" })
    end,
  }

}
