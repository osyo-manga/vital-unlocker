call vital#of("vital").unload()
let s:Holder = vital#of("vital").import("Unlocker.Holder")


function! s:test_as_deepcopy_value_dict()
	let dict = { "homu" : 42, "mami" : 42 }

	let value = s:Holder.value(dict)
	let holder = s:Holder.as_get_deepcopy(s:Holder.value(dict))
	OwlCheck value isnot holder
	OwlCheck value.get() isnot holder.get()

	OwlCheck holder.get() == dict
	OwlCheck holder.get() isnot dict

	let dict.homu = 0
	OwlCheck holder.get().homu == 0

	let dict.mado = 0
	OwlCheck holder.get().mado == 0

	let tmp = holder.get()
	let tmp.mami = 0
	OwlCheck dict.mami == 42

	call holder.set({ "homu" : 42, "mami" : 42 })
	OwlCheck dict == { "homu" : 42, "mami" : 42 }
endfunction


function! s:test_as_get_deepcopy_variable()
	let g:unlocker_holder_variable_test_value = { "value" : 42 }
	let holder = s:Holder.as_get_deepcopy(s:Holder.variable("g:unlocker_holder_variable_test_value"))

	OwlCheck holder.get() == { "value" : 42 }
	OwlCheck holder.get() isnot g:unlocker_holder_variable_test_value

	let g:unlocker_holder_variable_test_value.value = 0
	OwlCheck holder.get() == { "value" : 0 }

	let tmp = holder.get()
	let tmp.value = 42
	OwlCheck g:unlocker_holder_variable_test_value.value == 0

	unlet g:unlocker_holder_variable_test_value
endfunction


function! s:test_as_get_deepcopy()
	let base = { "value" : {} }

	function! base.get()
		return self.value
	endfunction

	let holder = s:Holder.as_get_deepcopy(base)
	OwlCheck holder.get() isnot base.value

	let holder2 = s:Holder.as_get_deepcopy(holder)
	OwlCheck holder.get() isnot holder2.get()
endfunction


function! s:test_as_set_extend()
	let dict = { "value" : 42 }
	let holder = s:Holder.as_set_extend(s:Holder.value(dict))

	call holder.set({ "value2" : "homu" })
	OwlCheck dict.value  == 42
	OwlCheck dict.value2 == "homu"

	let dict.value = 0
	OwlCheck dict.value == 0
endfunction


function! s:test_option()
	let incsearch = &incsearch
	let holder = s:Holder.option("incsearch")
	
	let &incsearch = !incsearch
	OwlCheck holder.get() == !incsearch

	call holder.set(incsearch)
	OwlCheck &incsearch == incsearch
endfunction


