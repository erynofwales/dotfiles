-- Eryn Wells <eryn@erynwells.me>

require 'os'

function gitTopLevelDirectory()
    local handle = io.popen('git rev-parse --show-toplevel')
    if handle == nil then
        return nil
    end

    local gitRepoTopLevelDirectoryPath = vim.fn.trim(handle:read('*a'))
    handle:close()

    return gitRepoTopLevelDirectoryPath
end

-- Enable per-project (per-git repository) customization of (neo)vim by looking
-- for .vim and .nvim directories in the root of the git repository.
function addGitTopLevelDirectoryToRuntimePath()
    local gitTopLevelPath = gitTopLevelDirectory()
    if gitTopLevelPath == nil or string.len(gitTopLevelPath) == 0 then
        return
    end

    local repoVimPath = gitTopLevelPath .. "/.vim"
    if vim.fn.isdirectory(repoVimPath) == 1 then
        vim.opt.runtimepath:prepend(repoVimPath)
    end
    local repoNvimPath = gitTopLevelPath .. "/.nvim"
    if vim.fn.isdirectory(repoNvimPath) == 1 then
        vim.opt.runtimepath:prepend(repoNvimPath)
    end

    local repoVimAfterPath = gitTopLevelPath .. "/.nvim/after"
    if vim.fn.isdirectory(repoVimAfterPath) == 1 then
        vim.opt.runtimepath:append(repoVimAfterPath)
    end
    local repoNvimAfterPath = gitTopLevelPath .. "/.vim/after"
    if vim.fn.isdirectory(repoNvimAfterPath) == 1 then
        vim.opt.runtimepath:append(repoNvimAfterPath)
    end
end

vim.cmd [[
    source ~/.vimrc.common
    source ~/.vim/plugins.vim
]]

addGitTopLevelDirectoryToRuntimePath()

require 'autocommands'
require 'colors'
require 'configuration'
require 'diagnostics'
require 'treesitter'
require 'lsp'

local keys = require 'keys'
keys.init()

local gui = require 'gui'
gui.init()

function ErynEnsureMetadataDirectoriesExist()
    local paths = {
        vim.opt.backupdir:get(),
        vim.opt.directory:get(),
        vim.opt.undodir:get(),
    }

    local function makeDirectory(path)
        os.execute("mkdir -p " .. path)
    end

    for _, opt in ipairs(paths) do
        for _, value in ipairs(opt) do
            if string.find(value, "//$") then
                makeDirectory(value)
            end
        end
    end

    -- The shadafile option is a single option but get() returns a table, so
    -- iterate it just to be safe.
    for _, opt in ipairs(vim.opt.shadafile:get()) do
        local shadaDirectory = vim.fs.dirname(opt)
        makeDirectory(shadaDirectory)
    end
end

ErynEnsureMetadataDirectoriesExist()
