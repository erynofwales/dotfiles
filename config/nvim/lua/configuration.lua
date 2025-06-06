-- Eryn Wells <eryn@erynwells.me>

-- [[ Editor Configuration ]]
local opt = vim.opt

-- Reread files when they change outside of neovim
opt.autoread = true
-- Don't write files before switching buffers
opt.autowrite = false

opt.fileformats = {"unix", "dos", "mac"}

-- When creating splits, split on the right and below by default
opt.splitright = true
opt.splitbelow = true

-- Show line numbers
opt.number = true
opt.relativenumber = false

-- Start with ~all folds open.
opt.foldlevel = 99

-- Customize the status bar a bit. Show the ruler, mode, and the command as the
-- last line of the screen.
opt.ruler = true
opt.showmode = true
opt.showcmd = true

-- Never beep!
opt.visualbell = true
opt.errorbells = false

-- Wrap text rather than letting it run offscreen
opt.wrap = true
opt.linebreak = true
-- Wrap to 80 characters by default
opt.textwidth = 80
-- Mark columns 80, 90, and 120
opt.colorcolumn = {80, 90, 120}

-- Briefly show the matching parenthesis or bracket when typing one of those
-- characters.
opt.showmatch = true

opt.formatoptions:append("n")

-- When in list mode (showing whitespace) use some nicer Unicode characters.
opt.list = false
opt.listchars = {
    tab = "▸ ",
    eol = "¬",
    trail = "･",
    extends = "→",
    nbsp = "･",
}

-- Search options. Ignore case by default, but be case sensitive if the pattern
-- contains a capital. Incrementally search, rather than waiting until you hit
-- <Enter>. Search globally by default, rather than just on the current line.
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.gdefault = true

-- Prefer spaces to tabs. Indent tab characters 8 spaces, and soft indent 4
-- spaces. Never write tabs if you can help it.
opt.tabstop = 8
opt.shiftwidth = 4
opt.softtabstop = 4
opt.shiftround = true
opt.expandtab = true

-- Do some nice things when wrapping, joining, and copying.
opt.joinspaces = false
opt.autoindent = true
opt.copyindent = true

-- Always show the last command you typed.
opt.laststatus = 2

opt.background = "dark"

-- Save all this metadata while editing.
opt.backup = true
opt.undofile = true

local statedir = vim.fn.stdpath("state")
opt.backupdir = {statedir .. "/backup//"}
opt.directory = {statedir .. "/swap//", "."}
opt.undodir = {statedir .. "/undo//"}

-- Fields to save in the Shada file. Parameters as follows: (see :help shada)
--   %   number of buffers to save and restore when no file argument is given
--   '   maximum number of previously edited files for which marks are remembered
--   h   disable highlighted search patterns on start
--   /   omitted, so all search history is saved
--   <   maximum number of lines saved for each register
--   :   maximum number of lines of command history to save
--   s   shada entries over 100 KiB are skipped
opt.shada = {"%100", "'1000", "h", "<1000", ":1000", "s100"}
opt.shadafile = statedir .. "/shada/default.shada"

-- Scroll ahead of the point a bit in each direction
opt.scrolloff = 3
opt.sidescrolloff = 5

opt.wildmenu = true
opt.wildmode = {"longest", "list"}
opt.wildignore = {
    -- Build artifacts
    "*.o", "*.pyc", "*.lo", "*.class",
    -- Swap files
    "*~",
    -- Non-text things
    "*.db", "*.pdf", "*.jpg", "*.jpeg", "*.png", "*.gif",
    -- Auto-generated things
    ".git", "env", "migrations"
}

if vim.fn.has("mouse") then
    opt.mouse = "a"
end
