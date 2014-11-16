scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


function! s:_vital_loaded(V)
	let s:V = a:V
	let s:Base   = a:V.import("Unlocker.Rocker.Base")
	let s:Holder = a:V.import("Unlocker.Holder")
endfunction


function! s:_vital_depends()
	return [
\		"Unlocker.Rocker.Base",
\		"Unlocker.Holder",
\	]
endfunction


function! s:has_concept_locker(obj)
	return s:Base.has_concept_locker(a:obj)
endfunction


function! s:as_locker(obj)
	return s:Base.make(a:obj)
endfunction


function! s:value(value)
	return s:as_locker(s:Holder.as_get_deepcopy(s:Holder.value(a:value)))
endfunction


function! s:variable(value)
	return s:as_locker(s:Holder.as_get_deepcopy(s:Holder.variable(a:value)))
endfunction


function! s:any(...)
	return s:as_locker(s:Holder.as_get_deepcopy(call(s:Holder.any, a:000, s:Holder)))
endfunction


function! s:lock(...)
	return call("s:any", a:000).lock()
endfunction




let &cpo = s:save_cpo
unlet s:save_cpo
