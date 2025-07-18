local opt = vim.opt

--- Backup ---
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.expand '~/.cache/nvim/undodir'
opt.confirm = true -- prompt for save

--- Search ---
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

--- Indentation ---
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

opt.smartindent = true
opt.autoindent = true

--- Wrap ---
opt.wrap = false
opt.linebreak = true
opt.colorcolumn = '80'

--- Slide boundary ---
opt.scrolloff = 8
opt.sidescrolloff = 8

--- File encoding ---
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

--- Timeout ---
opt.updatetime = 300
opt.timeoutlen = 500
opt.ttimeoutlen = 0

--- Split ---
opt.splitright = true
opt.splitbelow = true

--- Fold ---
opt.foldmethod = 'marker'
opt.foldlevel = 99

--- Main UI ---
opt.number = true
opt.relativenumber = true

opt.cursorline = true
opt.showmode = false
opt.showtabline = 0
opt.laststatus = 3
opt.winborder = 'rounded' -- default float border
opt.cmdheight = 1

opt.termguicolors = true
opt.guicursor = '' -- solid block
opt.signcolumn = 'yes'

opt.title = true
opt.titlestring = '%t%( %M%)%( (%{expand("%:~:h")})%)%a (nvim)'

--- Popup menu ---
opt.completeopt = 'menuone,noselect,noinsert'
opt.pumheight = 10
opt.pumblend = 10

--- Misc ---
opt.mouse = 'n' -- allow mouse in normal
opt.lazyredraw = true -- delay redraw during macros
opt.inccommand = 'split' -- preview substitutions live
opt.shortmess:append { w = true, s = true }

vim.schedule(function()
    opt.clipboard = 'unnamedplus'
end)

--- Disable builtin plugins & providers ---
for _, plugin in pairs {
    'netrw',
    'netrwPlugin',
    'netrwSettings',
    'netrwFileHandlers',
    'gzip',
    'zip',
    'zipPlugin',
    'tar',
    'tarPlugin',
    'getscript',
    'getscriptPlugin',
    'vimball',
    'vimballPlugin',
    '2html_plugin',
    'logipat',
    'rrhelper',
    'spellfile_plugin',
    'matchit',
    'python3_provider',
    'ruby_provider',
    'perl_provider',
    'node_provider',
} do
    vim.g['loaded_' .. plugin] = 1
end
