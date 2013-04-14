setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab

let s:buf_filename = expand('%:t')
if s:buf_filename != "SConscript" && s:buf_filename != "SConstruct"
    setlocal textwidth=80
    setlocal colorcolumn=80
else
    setlocal textwidth=80
    setlocal colorcolumn=80
endif

"setlocal foldnestmax=3
"setlocal fdm=indent

setlocal makeprg="pylint -f parseable %"
