scriptencoding utf-8

if !exists('g:loaded_comment')
    finish
endif

let g:loaded_comment = 1

let s:save_cpo = &cpo
set cpo&vim

function! comment#switch(method, mode)
    let l:first_expr = a:mode == 'n' ? '.' : "'<"
    let l:last_expr = a:mode == 'n' ? '.' : "'>"
    let [l:first] = getpos(l:first_expr)[1:1]
    let [l:last] = getpos(l:last_expr)[1:1]

    if a:method ==# 'out'
        for n in range(l:first, l:last)
            call setline(n, b:comment_out_line . getline(n))
        endfor
    endif

    if a:method ==# 'in'
        let pattern = '^\(\s*\)' . b:comment_out_line

        for n in range(l:first, l:last)
            let sub = substitute(getline(n), pattern, '\1', '')
            call setline(n, sub)
        endfor
    endif

    call cursor(l:last, 0)
endfunction

function! comment#out(mode)
  call comment#switch('out', a:mode)
endfunction

function! comment#in(mode)
  call comment#switch('in', a:mode)
endfunction

command! -range -nargs=+ Comment call comment#switch(<f-args>)
command! -range -nargs=1 CommentOut call comment#out(<f-args>)
command! -range -nargs=1 CommentIn call comment#in(<f-args>)

let &cpo = s:save_cpo
unlet s:save_cpo

