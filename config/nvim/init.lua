-- Eryn Wells <eryn@erynwells.me>

vim.opt.runtimepath:prepend "~/.vim"
vim.cmd [[ source ~/.vimrc.common ]]

require 'configuration'
require 'keys'
require 'os'

vim.cmd [[ source ~/.vim/plugins.vim ]]

function ensure_metadata_directories_exist()
    paths = {
        vim.opt.backupdir:get(),
        vim.opt.directory:get(),
        vim.opt.undodir:get()
    }

    for _, opt in ipairs(paths) do
        local firstPath = opt[1]
        if string.find(firstPath, "//$") then
            os.execute("mkdir", "-p", firstPath)
        end
    end
end

ensure_metadata_directories_exist()
