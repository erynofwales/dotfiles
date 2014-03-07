" Vim filetype plugin file
" Language:	SCons files
" Maintainer:	Eryn Wells <eryn@erynwells.me>
" Version: 0.1

" Only do this when not done yet for this buffer
if exists("b:did_scons_ftplugin")
   finish
endif
" Don't load another plug-in for this buffer
let b:did_scons_ftplugin = 1

augroup filetype_scons
   autocmd!
   autocmd BufNewFile,BufRead SCons{truct,cript} set ft=python
augroup END
