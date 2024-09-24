if exists("b:current_syntax")
  finish
endif

if !exists("g:main_syntax")
  let g:main_syntax = 'css'
endif

runtime! syntax/gotexttmpl.vim
runtime! syntax/css.vim
unlet b:current_syntax

syn cluster htmlPreproc add=gotplAction,goTplComment

let b:current_syntax = "gocsstmpl"

" vim: sw=2 ts=2 et
