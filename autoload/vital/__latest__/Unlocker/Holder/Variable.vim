scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim
let s:obj = {}


function! s:obj.get()
	return eval(self.__name)
endfunction


function! s:obj.set(value)
	execute "let " . self.__name . " = a:value"
endfunction


function! s:make(name)
	let result = deepcopy(s:obj)
	let result.__name = a:name
	return result
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
