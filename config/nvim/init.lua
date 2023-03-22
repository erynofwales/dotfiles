-- Eryn Wells <eryn@erynwells.me>

vim.cmd [[
    source ~/.vimrc.common
    source ~/.vim/plugins.vim 
]]

require 'os'

require 'configuration'
require 'colors'
require 'keys'

function ensureMetadataDirectoriesExist()
    local options = {
        vim.opt.backupdir:get(),
        vim.opt.directory:get(),
        vim.opt.undodir:get(),
    }

    local function makeDirectory(path)
        os.execute("mkdir", "-p", path)
    end

    for _, opt in ipairs(options) do
        for _, path in ipairs(opt) do
            if string.find(path, "//$") then
                makeDirectory(path)
            end
        end
    end

    -- The shadafile option is a single option but get() returns a table, so
    -- iterate it just to be safe.
    local shadaFile = vim.opt.shadafile:get()
    for _, path in ipairs(shadaFile) do
        local shadaFileDirectory = vim.fs.dirname(path)
        makeDirectory(shadaFileDirectory)
    end
end

ensureMetadataDirectoriesExist()
