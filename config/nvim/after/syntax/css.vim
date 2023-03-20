" css.vim
" Eryn Wells <eryn@erynwells.me>

syn match cssLogicalBoxProp contained "\<padding-\(block\|inline\)\=\(-\(start\|end\)\)\=\>"
syn match cssLogicalBoxProp contained "\<margin-\(block\|inline\)\=\(-\(start\|end\)\)\=\>"

hi def link cssLogicalBoxProp cssProp
