

call vital#of("vital").unload()
let s:Variable = vital#of("vital").import("Unlocker.Holder.Variable")


function! s:test_variable()
	let g:unlocker_holder_variable_test_value = 42

	let holder = s:Variable.make("g:unlocker_holder_variable_test_value")
	OwlCheck holder.get() == 42

	let g:unlocker_holder_variable_test_value = 0
	OwlCheck holder.get() == 0

	call holder.set(42)
	OwlCheck g:unlocker_holder_variable_test_value == 42

	unlet g:unlocker_holder_variable_test_value
endfunction


function! s:test_variable_dict()
	let g:unlocker_holder_variable_test_value = { "value" : 42 }
	let holder = s:Variable.make("g:unlocker_holder_variable_test_value")

	OwlCheck holder.get() == { "value" : 42 }
	OwlCheck holder.get() is g:unlocker_holder_variable_test_value

	let g:unlocker_holder_variable_test_value.value = 0
	OwlCheck holder.get() == { "value" : 0 }

	let tmp = holder.get()
	let tmp.value = 42
	OwlCheck g:unlocker_holder_variable_test_value.value == 42

	unlet g:unlocker_holder_variable_test_value
endfunction


function! s:test_variable_deepcopy()
	let g:unlocker_holder_variable_test_value = { "value" : 42 }
	let holder = s:Variable.make_deepcopy("g:unlocker_holder_variable_test_value")

	OwlCheck holder.get() == { "value" : 42 }
	OwlCheck holder.get() isnot g:unlocker_holder_variable_test_value

	let g:unlocker_holder_variable_test_value.value = 0
	OwlCheck holder.get() == { "value" : 0 }

	let tmp = holder.get()
	let tmp.value = 42
	OwlCheck g:unlocker_holder_variable_test_value.value == 0

	unlet g:unlocker_holder_variable_test_value
endfunction



function! s:test_is_makeable()
	let Variable = s:Variable
	
	let g:unlocker_holder_variable_test_value = 10
	OwlCheck  Variable.is_makeable("&incsearch")
	OwlCheck  Variable.is_makeable("&l:incsearch")
	OwlCheck  Variable.is_makeable("g:unlocker_holder_variable_test_value")
	OwlCheck !Variable.is_makeable("unlocker_holder_variable_test_value")
	OwlCheck !Variable.is_makeable("&g:unlocker_holder_variable_test_value")
	OwlCheck !Variable.is_makeable("incsearch")
	OwlCheck !Variable.is_makeable("")
	OwlCheck !Variable.is_makeable("0")
	OwlCheck !Variable.is_makeable({})
	OwlCheck !Variable.is_makeable(0)
	unlet g:unlocker_holder_variable_test_value
endfunction

