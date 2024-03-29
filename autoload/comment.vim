scriptencoding utf-8

if !exists('g:loaded_comment')
    finish
endif

let g:loaded_comment = 1

let s:save_cpo = &cpo
set cpo&vim

"TODO comment#toggle()
"a:firstline, a:lastlineが取れるようになったらrangeと共にそっちを使う
"visual modeだけでなくnormal modeの.,.+5call COMMANDもそれでいける
function! comment#toggle(method, mode)
    if b:comment_char ==# ''
      echo 'Comment char is empty.'
      return
    endif

    let l:first_expr = a:mode == 'n' ? '.' : "'<"
    let l:last_expr = a:mode == 'n' ? '.' : "'>"
    let [l:first] = getpos(l:first_expr)[1:1]
    let [l:last] = getpos(l:last_expr)[1:1]

    if a:method ==# 'out'
        for n in range(l:first, l:last)
            call setline(n, b:comment_char . getline(n))
        endfor
    endif

    if a:method ==# 'in'
        let pattern = '^\(\s*\)' . b:comment_char

        for n in range(l:first, l:last)
            let sub = substitute(getline(n), pattern, '\1', '')
            call setline(n, sub)
        endfor
    endif

    call cursor(l:last, 0)
endfunction

function! comment#out(mode)
  call comment#toggle('out', a:mode)
endfunction

function! comment#in(mode)
  call comment#toggle('in', a:mode)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

