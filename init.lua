-- ~/.config/nvim/init.lua

-- Temel ayarlar
vim.opt.number = true              -- Satır numaralarını göster
vim.opt.relativenumber = true      -- Göreceli satır numaraları
vim.opt.mouse = 'a'                -- Mouse desteğini etkinleştir
vim.opt.ignorecase = true          -- Aramada büyük/küçük harf duyarsız
vim.opt.smartcase = true           -- Büyük harf varsa duyarlı ol
vim.opt.hlsearch = false           -- Arama vurgulamasını kapat
vim.opt.wrap = false               -- Satır sarmalamayı kapat
vim.opt.breakindent = true         -- Wrapped satırlarda indent koru
vim.opt.tabstop = 4                -- Tab boyutu
vim.opt.shiftwidth = 4             -- Indent boyutu
vim.opt.expandtab = true           -- Tab yerine space kullan
vim.opt.smartindent = true         -- Akıllı indentleme
vim.opt.termguicolors = true       -- True color desteği
vim.opt.signcolumn = 'yes'         -- Sign column'u her zaman göster
vim.opt.updatetime = 250           -- Güncelleme süresi
vim.opt.timeoutlen = 300           -- Key mapping timeout
vim.opt.scrolloff = 10             -- Cursor etrafında minimum satır sayısı
vim.opt.sidescrolloff = 8          -- Cursor etrafında minimum sütun sayısı
vim.opt.guicursor = "i-ci-ve:block" -- Insertte Block Cursor

-- Syntax highlighting'i etkinleştir
vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')

-- Clipboard sistem panosunu kullan
vim.opt.clipboard = 'unnamedplus'

-- Split ayarları
vim.opt.splitbelow = true          -- Yatay split aşağıda açılsın
vim.opt.splitright = true          -- Dikey split sağda açılsın

-- Backup ve swap dosyalarını kapat
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Temel keybindler
vim.g.mapleader = ' '              -- Leader key'i space yap
vim.g.maplocalleader = ' '

-- ===============================================
-- PAKET YÖNETİCİSİ: Lazy.nvim
-- ===============================================

-- Lazy.nvim'i bootstrap et
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin'leri yükle
require("lazy").setup({
  -- ===============================================
  -- TREESITTER - Modern Syntax Highlighting
  -- ===============================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Yüklenecek diller
        ensure_installed = {
          "python",
          "javascript",
          "typescript",
          "tsx",
          "html",
          "css",
          "json",
          "lua",
          "bash",
          "markdown",
          "yaml",
          "toml",
          "vim",
          "vimdoc",
          "go",
          "rust",
          "c",
          "cpp",
        },

        -- Otomatik yükleme
        auto_install = true,

        -- Syntax highlighting
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },

        -- Indentation
        indent = {
          enable = true,
        },

        -- Incremental selection
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      })
    end,
  },

  -- ===============================================
  -- TELESCOPE - Fuzzy Finder
  -- ===============================================
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable "make" == 1
        end,
      },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
        pickers = {
          find_files = {
            theme = "dropdown",
          },
          live_grep = {
            theme = "dropdown",
          },
          buffers = {
            theme = "dropdown",
          },
        },
      })

      -- FZF extension'ı yükle (eğer varsa)
      pcall(require("telescope").load_extension, "fzf")
    end,
  },
})

-- ===============================================
-- DİL SPESIFIK AYARLAR
-- ===============================================

-- Python için
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
  end,
})

-- JavaScript/TypeScript için
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- HTML/CSS için
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "css", "scss", "json" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- ===============================================
-- TELESCOPE KEYBİNDLER
-- ===============================================

-- Telescope keybindings
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Dosya ara' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Metin ara' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = 'Buffer ara' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Help ara' })
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').oldfiles, { desc = 'Son dosyalar' })
vim.keymap.set('n', '<leader>fc', require('telescope.builtin').commands, { desc = 'Komutlar' })
vim.keymap.set('n', '<leader>fk', require('telescope.builtin').keymaps, { desc = 'Keymaps' })

-- ===============================================
-- ESKİ KEYBİNDLER (değişiklik yok)
-- ===============================================

-- Typo fix'leri
vim.cmd('command! Q q')
vim.cmd('command! Wq wq')
vim.cmd('command! WQ wq')
vim.cmd('command! W w')
vim.cmd('command! Qa qa')
vim.cmd('command! QA qa')

-- Hızlı ESC için jk kombinasyonu
vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode' })

-- Window navigasyonu
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Sol pencereye git' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Alt pencereye git' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Üst pencereye git' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Sağ pencereye git' })

-- Buffer navigasyonu
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', { desc = 'Önceki buffer' })
vim.keymap.set('n', '<S-l>', ':bnext<CR>', { desc = 'Sonraki buffer' })

-- Satır hareket ettirme
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Seçili satırları aşağı taşı' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Seçili satırları yukarı taşı' })

-- Search ve replace için merkezi konum
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Sonraki arama sonucu (merkezle)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Önceki arama sonucu (merkezle)' })

-- Arama vurgulamasını temizle
vim.keymap.set('n', '<leader>h', ':nohl<CR>', { desc = 'Arama vurgulamasını temizle' })

-- Dosya kaydetme
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Dosyayı kaydet' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Çık' })
vim.keymap.set('n', '<leader>wq', ':wq<CR>', { desc = 'Kaydet ve çık' })

-- Netrw (built-in file explorer) ayarları
vim.g.netrw_banner = 0             -- Banner'ı gizle
vim.g.netrw_browse_split = 0       -- Aynı pencerede aç
vim.g.netrw_altv = 1               -- Vertical split sağda
vim.g.netrw_winsize = 25           -- Pencere boyutu
vim.keymap.set('n', '<leader>e', ':Explore<CR>', { desc = 'File explorer aç' })

-- Auto commands
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight on yank
autocmd('TextYankPost', {
  group = augroup('highlight_yank', {}),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Trailing whitespace'leri kaldır
autocmd('BufWritePre', {
  group = augroup('trim_whitespace', {}),
  pattern = '*',
  callback = function()
    local save_cursor = vim.fn.getpos('.')
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos('.', save_cursor)
  end,
})
