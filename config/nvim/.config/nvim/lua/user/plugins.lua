local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

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
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

return packer.startup(function(use)
  use "wbthomason/packer.nvim"
  -- Colorschemes
  use({
    "folke/tokyonight.nvim",
    commit = "1ee11019f8a81dac989ae1db1a013e3d582e2033"
  })
  use({
    "lunarvim/colorschemes", -- A bunch of colorschemes you can try out
    commit = "e29f32990d6e2c7c3a4763326194fbd847b49dac"
  })
  use({
    "ziontee113/color-picker.nvim",
    commit = "06cb5f853535dea529a523e9a0e8884cdf9eba4d",
    config = function()
      require("color-picker")
    end,
  })
  -- use "roobert/tailwindcss-colorizer-cmp.nvim"
  use({
    "NvChad/nvim-colorizer.lua",
    commit = "dde3084106a70b9a79d48f426f6d6fec6fd203f7"
  })
  use({
    "lunarvim/darkplus.nvim",
    commit = "7c236649f0617809db05cd30fb10fed7fb01b83b"
  })
  use { "rose-pine/neovim", commit = "e29002cbee4854a9c8c4b148d8a52fae3176070f" }
  use({ "ellisonleao/gruvbox.nvim", commit = "353be593e52e2008ce17d61208668747dd557248" })
  use({ "arcticicestudio/nord-vim", commit = "f13f5dfbb784deddbc1d8195f34dfd9ec73e2295" })
  use({ "nvim-telescope/telescope.nvim", commit = "2d92125620417fbea82ec30303823e3cd69e90e8" })
  use({ "nvim-lua/plenary.nvim", commit = "267282a9ce242bbb0c5dc31445b6d353bed978bb" })
  use({ "nvim-treesitter/nvim-treesitter", commit = "898f9c13d60bd51bdf873e284177f98264f0954f" })
  use({ "nvim-lua/popup.nvim", commit = "b7404d35d5d3548a82149238289fa71f7f6de4ac" })
  use({ "pedrohms/impatient.nvim", commit = "main" })
  -- All the things
  use({ "williamboman/mason.nvim", commit = "74eac861b013786bf231b204b4ba9a7d380f4bd9" })
  use({ "williamboman/mason-lspconfig.nvim", commit = "e86a4c84ff35240639643ffed56ee1c4d55f538e" })
  use({ "neovim/nvim-lspconfig", commit = "7c73a4dc44c3d62ee79ab9f03ba313251c0388d4" })
  use({ "onsails/lspkind-nvim", commit = "57610d5ab560c073c465d6faf0c19f200cb67e6e" })
  use({ "pedrohms/lsp_extensions.nvim", commit = "master" })
  use({ "ray-x/lsp_signature.nvim", commit = "58d4e810801da74c29313da86075d6aea537501f" })
  use({ "lvimuser/lsp-inlayhints.nvim", commit = "d981f65c9ae0b6062176f0accb9c151daeda6f16" })
  use({ "hrsh7th/cmp-nvim-lsp", commit = "44b16d11215dce86f253ce0c30949813c0a90765" })
  use({ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" })
  use({ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" })
  use({ "hrsh7th/nvim-cmp", commit = "3b9f28061a67b19cadc13946de981426a6425e4a" })
  use({ "glepnir/lspsaga.nvim", commit = "e552e9d2ffc7ba99e1a2f51764b48ad4c668ada4" })
  use({ "akinsho/flutter-tools.nvim", commit = "561d85b16d8ca2938820a9c26b2fe74096d89c81",
    requires = "nvim-lua/plenary.nvim" })
  use({ "simrat39/symbols-outline.nvim", commit = "512791925d57a61c545bc303356e8a8f7869763c" })
  use({ "saadparwaiz1/cmp_luasnip", commit = "18095520391186d634a0045dacaa346291096566" })
  use({ "goolord/alpha-nvim", commit = "e4fc5e29b731bdf55d204c5c6a11dc3be70f3b65" })
  use({ "tom-anders/telescope-vim-bookmarks.nvim", commit = "92498cbf7c127dea37c3d27117b60dd7ab9baef4" })
  use({ "MattesGroeger/vim-bookmarks", commit = "9cc5fa7ecc23b052bd524d07c85356c64b92aeef" })
  use({ "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons", -- optional, for file icons
    }, commit = "904f95cd9db31d1800998fa428e78e418a50181d"   -- optional, updated every week. (see issue #1193)
  })
  use ({
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
      }
    end,
    commit = "8c6bad7d22eef1b71144b401c9f74ed01526a4fb"
  })
  use ({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
    commit = "0236521ea582747b58869cb72f70ccfa967d2e89"
  })
  use ({ "akinsho/bufferline.nvim", commit = "99f0932365b34e22549ff58e1bea388465d15e99", requires = "kyazdani42/nvim-web-devicons" })
  use ({ "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig", commit = "9c89730da6a05acfeb6a197e212dfadf5aa60ca0" })
  use ({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    commit = "45e27ca739c7be6c49e5496d14fcf45a303c3a63"
  })
  use({ "akinsho/toggleterm.nvim", commit = "12cba0a1967b4f3f31903484dec72a6100dcf515" })
  use({ "tamago324/nlsp-settings.nvim", commit = "64976a5ac70a9a43f3b1b42c5b1564f7f0e4077e" })       -- language server settings defined in json for
  use({ "jose-elias-alvarez/null-ls.nvim", commit = "db09b6c691def0038c456551e4e2772186449f35" })    -- for formatters and linters
  use({ "lukas-reineke/indent-blankline.nvim", commit = "4541d690816cb99a7fc248f1486aa87f3abce91c" })
  -- use({ "pedrohms/surround.nvim", commit = "master" })
  use({ "windwp/nvim-ts-autotag", commit = "6be1192965df35f94b8ea6d323354f7dc7a557e4" })
  use({ "windwp/nvim-autopairs", commit = "ae5b41ce880a6d850055e262d6dfebd362bb276e" })
  use({ "tpope/vim-surround", commit = "3d188ed2113431cf8dac77be61b842acb64433d9" })
  use({ "mfussenegger/nvim-jdtls" })
  use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
  -- snippets
  use({ "rafamadriz/friendly-snippets", commit = "" })    -- a bunch of snippets to use
  use({ "L3MON4D3/LuaSnip", commit = "" })
  use({ "ThePrimeagen/harpoon", commit = "" })
  -- DAP
  use({ "mfussenegger/nvim-dap", commit = "" })
  use({ "theHamsta/nvim-dap-virtual-text", commit = "" })
  use({ "rcarriga/nvim-dap-ui", commit = "" })
  use({ "pedrohms/dap-install", commit = "" })
  use({ "rcarriga/cmp-dap", commit = "" })
  use({ "lewis6991/gitsigns.nvim", commit = "" })
  use({ "mattn/vim-gist", commit = "" })
  use({ "mattn/webapi-vim", commit = "" })
  use({ "tpope/vim-fugitive", commit = "" })
  use({ "ThePrimeagen/git-worktree.nvim", commit = "" })
  use({ "TimUntersberger/neogit", commit = "" })
  use({ "sindrets/diffview.nvim", commit = "" })
  use({ "RRethy/vim-illuminate", commit = "" })
  use({ "stevearc/dressing.nvim", commit = "" })
  use({ "rcarriga/nvim-notify", commit = "" })
  use({ "nacro90/numb.nvim", commit = "" })
  use({ "windwp/nvim-spectre", commit = "" })
  use { "jinh0/eyeliner.nvim",
    config = function()
      require("eyeliner").setup {
        highlight_on_key = true,
      }
    end }
  use({ "xiyaowong/transparent.nvim", commit = "" })
  use({ "catppuccin/nvim", as = "catppuccin", commit = "" })
end)
