call vital#of("vital").unload()
let s:Rocker = vital#of("vital").import("Unlocker.Rocker")


function! s:test_value()
	let dict = { "homu" : 42, "mami" : 42 }
	let locker = s:Rocker.value(dict).lock()
	let dict.homu = 0
	let dict.mami = 0
	let dict.mado = 0
	call locker.unlock()
	OwlCheck dict == { "homu" : 42, "mami" : 42 }
endfunction


function! s:test_variable()
	let g:coaster_rocker_variable_test_variable = 42
	let locker = s:Rocker.variable("g:coaster_rocker_variable_test_variable").lock()
	let g:coaster_rocker_variable_test_variable = 0
	call locker.unlock()
	OwlCheck g:coaster_rocker_variable_test_variable == 42
	unlet g:coaster_rocker_variable_test_variable
endfunction


function! s:test_any()
	let dict = { "homu" : 42, "mami" : 42 }
	let incsearch = &incsearch
	let modifiable = &modifiable

	let lockers = s:Rocker.any(dict, "incsearch", "&modifiable")
	call lockers.lock()

	let dict.homu = 0
	let dict.mami = 0
	let dict.mado = 0
	let &incsearch = !incsearch
	let &modifiable = !modifiable

	call lockers.unlock()

	OwlCheck dict == { "homu" : 42, "mami" : 42 }
	OwlCheck &incsearch  == incsearch
	OwlCheck &modifiable == modifiable
endfunction


function! s:test_lock_local_value()
	let homu = 42
	let mami = -1
	let locker = s:Rocker.lock(l:)
	let homu = 0
	let mami = 0
	let mado = 0
	call locker.unlock()
	OwlCheck homu == 42
	OwlCheck mami == -1
	OwlCheck !exists("mado")
endfunction


