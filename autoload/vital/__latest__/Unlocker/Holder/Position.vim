scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim

let s:obj = {}

function! s:obj.get()
	return getpos(self.__expr)
endfunction


function! s:obj.set(value)
	call setpos(self.__expr, a:value)
endfunction


function! s:has_concept(expr)
	return a:expr =~ 'w$\|w0\|[v.$]\|''[a-zA-Z]'
endfunction


function! s:make(expr)
	let result = deepcopy(s:obj)
	let result.__expr = a:expr
	return result
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
