set foldmethod=syntax
set sw=4 sts=4
set noet

"For the new omni-completion ":help ft-c-omni"
if has('mac')
    set tags+=~/.vim/systags-osx
elseif has('linux')
    set tags+=~/.vim/systags-linux
endif
