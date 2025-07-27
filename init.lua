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
