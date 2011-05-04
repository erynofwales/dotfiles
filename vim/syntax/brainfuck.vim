" brainfuck.vim
" Author: Eryn Wells <eryn@3b518c.com>
" Last Modified: 2010-11-09

syn match IncrementPtr '>'
syn match DecrementPtr '<'
syn match IncrementVal '+'
syn match DecrementVal '-'
syn match OutputVal '\.'
syn match InputVal ','
syn match LoopStart '\['
syn match LoopEnd ']'
syn match Comment '[^><+\-.,[\]]*' contains=ALL

hi IncrementPtr ctermfg=blue
hi DecrementPtr	ctermfg=blue
hi IncrementVal ctermfg=green
hi DecrementVal ctermfg=green
hi OutputVal ctermfg=magenta
hi InputVal ctermfg=magenta
hi LoopStart ctermfg=cyan
hi LoopEnd ctermfg=cyan
hi Comment ctermfg=grey
