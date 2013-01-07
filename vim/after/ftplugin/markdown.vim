setlocal tw=80
setlocal cc=80
setlocal fdm=marker
setlocal spell

" Comment out the current selection
vmap <buffer> <leader>co "xdi<!--<Esc>"xpa--><Esc>
