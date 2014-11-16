scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


function! s:_vital_loaded(V)
	let s:V = a:V
	let s:Variable = a:V.import("Unlocker.Holder.Variable")
	let s:Value = a:V.import("Unlocker.Holder.Value")
	let s:Multi = a:V.import("Unlocker.Holder.Multi")
	let s:Any   = a:V.import("Unlocker.Holder.Any")
endfunction


function! s:_vital_depends()
	return [
\		"Unlocker.Holder.Variable",
\		"Unlocker.Holder.Value",
\		"Unlocker.Holder.Multi",
\		"Unlocker.Holder.Any",
\	]
endfunction


function! s:as_get_deepcopy(holder)
	if has_key(a:holder, "__holder_as_get_deepcopy_get")
		return a:holder
	endif
	let result = copy(a:holder)
	let result.__holder_as_get_deepcopy_get = result.get
	function! result.get()
		return deepcopy(self.__holder_as_get_deepcopy_get())
	endfunction
	return result
endfunction


function! s:as_set_extend(holder)
	if has_key(a:holder, "__holder_as_set_extend_set")
		return a:holder
	endif
	let result = copy(a:holder)
	let result.__holder_as_set_extend_set = result.set
	function! result.set(value)
		let result = deepcopy(extend(self.get(), a:value))
		call self.__holder_as_set_extend_set(result)
	endfunction
	return result
endfunction


function! s:variable(name)
	return s:Variable.make(a:name)
endfunction


function! s:value(value)
	return s:Value.make(a:value)
endfunction


function! s:option(name)
	return s:Variable.make("&" . a:name)
endfunction


function! s:multi(value)
	return s:Multi.make(a:value)
endfunction


function! s:any(...)
	return call(s:Any.make, a:000, s:Any)
endfunction



let &cpo = s:save_cpo
unlet s:save_cpo
