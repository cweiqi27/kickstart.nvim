-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--
return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
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
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end,
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  { "elkowar/yuck.vim",            enabled = true },
  { "MunifTanjim/nui.nvim",        enabled = true },
  { "nvim-tree/nvim-web-devicons", enabled = true },
  { "nvim-lua/plenary.nvim",       enabled = true },
  {
    "edluffy/hologram.nvim",
    enabled = true,
    opts = {
      auto_display = true
    }
  },
  -- { "windwp/nvim-autopairs",
  --     config = function() require("nvim-autopairs").setup {} end
  -- },
  {
    'andweeb/presence.nvim',
    enabled = true,
    opts = {
      enable_line_number = true,
      buttons = false
    }
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    requires = 'nvim-tree/nvim-web-devicons',
    opts = {

    }
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
      })
    end
  },
  { 'mg979/vim-visual-multi' },
  { 'ap/vim-css-color' },
}
