" cpp.vim
" Eryn Wells <eryn@erynwells.me


syn keyword cppSpecifier constexpr override final noexcept

if version >= 508 || !exists("did_erw_cpp_syntax_inits")
    if version < 508
        let did_erw_cpp_syntax_inits = 1
        command -nargs=+ HiLink hi link <args>
    else
        command -nargs=+ HiLink hi def link <args>
    endif
    HiLink cppSpecifier Type
    delcommand HiLink
endif


function! GetNamespaces()
    " Save the cursor
    let l = line('.')
    let c = col('.')

    let pattern = '\v^namespace\s+(\w+)\s*\{'

    let namespaces = []
    let lastLine = search(pattern, 'bW')
    while lastLine > 0
        echo 'Found namespace header on line ' . lastLine

        " Find matching brace
        normal %
        echo 'Found closing brace on line ' . line('.')

        if line('.') < lastLine
            " We've skipped into a new namespace block. We're done.
            echo 'New namespace block; breaking'
            break
        endif

        " Jump back to the starting brace
        normal %
        echo 'Back to line ' . line('.')

        let ns = substitute(getline('.'), pattern, '\1', '') 
        echo 'Found namespace: ' . ns
        if ns !=# ''
            call insert(namespaces, ns, 0)
            echo 'Namespaces so far: ' . string(namespaces)
        endif

        " Search for the next namespace
        echo 'Searching again...'
        let searchLine = search(pattern, 'bW')
    endwhile

    " Restore the cursor position
    call cursor(l, c)

    return namespace
endfunction
