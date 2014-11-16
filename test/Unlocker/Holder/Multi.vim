call vital#of("vital").unload()
let s:Holder = vital#of("vital").import("Unlocker.Holder")
let s:Multi = vital#of("vital").import("Unlocker.Holder.Multi")


function! s:test_get()
	let dict = { "value" : 1 }

	let holder = s:Multi.make([s:Holder.value(dict), s:Holder.value(dict)])
	OwlCheck holder.get() == [{ "value" : 1 }, { "value" : 1 }]

	let dict.value = 42
	OwlCheck holder.get() == [{ "value" : 42 }, { "value" : 42 }]
endfunction


function! s:test_get()
	let g:unlocker_holder_variable_test_value = 10
	let dict = { "value" : 1 }

	let holder = s:Multi.make([s:Holder.value(dict), s:Holder.variable("g:unlocker_holder_variable_test_value")])

	call holder.set([{ "value2" : "homu" }, 42])

	OwlCheck holder.get() == [{ "value2" : "homu" }, 42]
	OwlCheck g:unlocker_holder_variable_test_value == 42
	OwlCheck dict == { "value2" : "homu" }

	unlet g:unlocker_holder_variable_test_value
endfunction


function! s:test_multi()
	let variable = s:Holder.option("incsearch")
	let dict = {}
	let value = s:Holder.value(dict)
	let holder = s:Multi.make([variable, value, s:Holder.as_get_deepcopy(value)])

	OwlCheck holder.get()[0] == &incsearch
	OwlCheck holder.get()[1] is dict
	OwlCheck holder.get()[2] isnot dict
endfunction

