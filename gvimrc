" List mode on here because the GUI has more color possibilities.
set list

if has('win32') || has('win64') || has('win32unix')
    set guifont=Inconsolata:h18
elseif has('mac')
    try
        set guifont=Source\ Code\ Pro:h13
    catch
        set guifont=Menlo:h11
    endtry
elseif has('linux')
    set guifont=Inconsolata\ 14
endif

set guioptions-=T       " turn off toolbar
set guioptions-=m       " turn off menubar
