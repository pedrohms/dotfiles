local fn = vim.fn

local install_path = fn.stdpath "data" .. "/lazy/lazy.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  LAZY_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    install_path,
  }
  print "Installing lazy close and reopen Neovim..."
end
vim.opt.rtp:prepend(install_path)

local jdtls_debug_path = vim.fn.stdpath "data" .. "/custom/dap/jdtls"
if vim.fn.empty(vim.fn.glob(jdtls_debug_path)) > 0 then
  DAP_JDTLS_BOOTSTRAP = vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/microsoft/java-debug",
    jdtls_debug_path,
  }
end

local jdtls_test_path = vim.fn.stdpath "data" .. "/custom/dap/jdtls-test"
if vim.fn.empty(vim.fn.glob(jdtls_test_path)) > 0 then
  DAP_JDTLS_BOOTSTRAP = vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/microsoft/vscode-java-test.git",
    jdtls_test_path,
  }
end
-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd [[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | Lazy
--   augroup end
-- ]]

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

return lazy.setup({
  { "lunarvim/colorschemes" },
  { "NvChad/nvim-colorizer.lua" },
  { "nvim-telescope/telescope.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "nvim-treesitter/nvim-treesitter" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "pedrohms/lsp_extensions.nvim" },
  { "ray-x/lsp_signature.nvim" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/nvim-cmp" },
  { "saadparwaiz1/cmp_luasnip" },
  { "goolord/alpha-nvim" },
  { "tom-anders/telescope-vim-bookmarks.nvim" },
  { "MattesGroeger/vim-bookmarks" },
  { "kyazdani42/nvim-tree.lua" },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
      }
    end
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end
  },
  { "SmiteshP/nvim-navic" },
  { "mfussenegger/nvim-jdtls" },
  { "moll/vim-bbye" },
  {
    "mfussenegger/nvim-lint",
  },
  -- snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
  },
  -- DAP
  { "mfussenegger/nvim-dap" },
  { "theHamsta/nvim-dap-virtual-text" },
  { "rcarriga/nvim-dap-ui" },
  { "pedrohms/dap-install" },
  { "rcarriga/cmp-dap" },
  -- END OF DAP
  --
  { "rcarriga/nvim-notify" },
  { "catppuccin/nvim",                as = "catppuccin" },
  -- { "kyazdani42/nvim-web-devicons"},
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-lualine/lualine.nvim", },
  { "gruvbox-community/gruvbox" },
  { "lewis6991/gitsigns.nvim" },
  -- { "sainnhe/gruvbox-material" },
  {
    'wittyjudge/gruvbox-material.nvim', priority = 1000, config = true
  },
  { "nvim-treesitter/nvim-treesitter-context" },
  -- Colorschemes
  -- { "folke/tokyonight.nvim" },
  -- { "ziontee113/color-picker.nvim" },
  -- use "roobert/tailwindcss-colorizer-cmp.nvim"
  -- { "lunarvim/darkplus.nvim" },
  -- { "rose-pine/neovim" },
  -- { "ellisonleao/gruvbox.nvim" },
  -- { "arcticicestudio/nord-vim" },
  -- { "nvim-lua/popup.nvim" },
  -- { "pedrohms/impatient.nvim" },
  -- All the things
  -- { "onsails/lspkind-nvim" },
  -- { "lvimuser/lsp-inlayhints.nvim" },
  -- { "glepnir/lspsaga.nvim" },
  -- { "akinsho/flutter-tools.nvim" },
  -- { "simrat39/symbols-outline.nvim" },
  -- { "akinsho/bufferline.nvim" },
  { "akinsho/toggleterm.nvim" },
  -- { "tamago324/nlsp-settings.nvim" },    -- language server settings defined in json for
  { "nvimtools/none-ls.nvim" }, -- for formatters and linters
  -- { "mhartington/formatter.nvim" },
  -- { "lukas-reineke/indent-blankline.nvim" },
  -- use({ "pedrohms/surround.nvim", commit = "master" })
  -- { "windwp/nvim-ts-autotag" },
  { "windwp/nvim-autopairs" },
  -- { "tpope/vim-surround" },

  -- snippets
  { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use
  -- { "ThePrimeagen/harpoon" },


  -- { "mattn/vim-gist" },
  -- { "mattn/webapi-vim" },
  -- { "tpope/vim-fugitive" },
  -- { "ThePrimeagen/git-worktree.nvim" },
  -- { "TimUntersberger/neogit" },
  -- { "sindrets/diffview.nvim" },
  { "RRethy/vim-illuminate" },
  { "stevearc/dressing.nvim" },
  -- { "nacro90/numb.nvim" },
  -- { "windwp/nvim-spectre" },
  {
    "jinh0/eyeliner.nvim",
    config = function()
      require("eyeliner").setup {
        highlight_on_key = true,
      }
    end
  },
  -- use({ "xiyaowong/transparent.nvim" })
  -- {
  --   "adalessa/laravel.nvim",
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --     "tpope/vim-dotenv",
  --     "MunifTanjim/nui.nvim",
  --   },
  --   cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
  --   keys = {
  --     { "<leader>la", ":Laravel artisan<cr>" },
  --     { "<leader>lr", ":Laravel routes<cr>" },
  --     { "<leader>lm", ":Laravel related<cr>" },
  --     {
  --       "<leader>lt",
  --       function()
  --         require("laravel.tinker").send_to_tinker()
  --       end,
  --       mode = "v",
  --       desc = "Laravel Application Routes",
  --     },
  --   },
  --   event = { "VeryLazy" },
  --   config = function()
  --     require("laravel").setup()
  --     require("telescope").load_extension "laravel"
  --   end,
  -- },
  -- { "ellisonleao/gruvbox.nvim" }
  -- {"jwalton512/vim-blade"}
})
