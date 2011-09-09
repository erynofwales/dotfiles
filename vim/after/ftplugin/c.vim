set foldmethod=syntax
set sw=4 sts=4
set noet

"For the new omni-completion ":help ft-c-omni"
if has('mac')
    set tags+=~/.vim/systags-osx
elseif has('linux')
    set tags+=~/.vim/systags-linux
endif

" Do comments that look like this:
" /* stuff and things
"    more stuff with things */
set comments="sO:* -,mO:   ,exO:*/,sl:/*,mb: ,ex:*/"

set cinoptions+=(0,Ws
