-- Eryn Wells <eryn@erynwells.me>

vim.opt.runtimepath:prepend "~/.vim"

vim.cmd [[
    source ~/.vimrc.common
    source ~/.vim/plugins.vim 
]]

require 'configuration'
require 'colors'
require 'keys'
require 'os'

function ensureMetadataDirectoriesExist()
    local paths = {
        vim.opt.backupdir:get(),
        vim.opt.directory:get(),
        vim.opt.undodir:get(),
        vim.fs.dirname(vim.opt.shadafile:get()),
    }

    for _, opt in ipairs(paths) do
        local firstPath = opt[1]
        if string.find(firstPath, "//$") then
            os.execute("mkdir", "-p", firstPath)
        end
    end
end

ensureMetadataDirectoriesExist()
