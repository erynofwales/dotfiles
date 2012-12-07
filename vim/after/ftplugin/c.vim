setlocal foldmethod=syntax
setlocal et

"For the new omni-completion ":help ft-c-omni"
if has('mac')
    setlocal tags+=~/.vim/systags-osx
elseif has('linux')
    setlocal tags+=~/.vim/systags-linux
endif

" Do comments that look like this:
" /* stuff and things
"    more stuff with things */
"setlocal comments="sO:* -,mO:   ,exO:*/,sl:/*,mb: ,ex:*/"

setlocal cinoptions+=(0,Ws
