call vital#of("vital").unload()
let s:V = vital#of("vital")
let s:Holder = s:V.import("Unlocker.Holder")
let s:Any = s:V.import("Unlocker.Holder.Any")
let s:Value = s:V.import("Unlocker.Holder.Value")
let s:Variable = s:V.import("Unlocker.Holder.Variable")
let s:Multi = s:V.import("Unlocker.Holder.Multi")


function! s:test_is_holder()
	let Any = s:Any
	OwlCheck !Any.is_holder(0)
	OwlCheck !Any.is_holder("")
	OwlCheck !Any.is_holder([])
	OwlCheck !Any.is_holder({})
	OwlCheck !Any.is_holder({ "get" : 42 })
	OwlCheck !Any.is_holder({ "set" : 42 })
	OwlCheck !Any.is_holder({ "set" : 42, "get" : 42 })
	OwlCheck !Any.is_holder({ "set" : 42, "get" : function("tr") })
	OwlCheck !Any.is_holder({ "get" : 42, "set" : function("tr") })

	OwlCheck Any.is_holder({ "get" : function("tr"), "set" : function("tr") })
endfunction


function! s:test_is_option()
	let Any = s:Any
	OwlCheck  Any.is_option("incsearch")
	OwlCheck  Any.is_option("l:incsearch")
	OwlCheck  Any.is_option("inc")
	OwlCheck !Any.is_option(" incsearch")
	OwlCheck !Any.is_option("in")
	OwlCheck !Any.is_option("hoge")
	OwlCheck !Any.is_option("&incsearch")
	OwlCheck !Any.is_option({})
	OwlCheck !Any.is_option("")
	OwlCheck !Any.is_option(0)
endfunction


function! s:test_is_variable()
	let Any = s:Any
	let g:unlocker_holder_any_test_value = 0
	let b:unlocker_holder_any_test_value = 0

	OwlCheck  Any.is_variable("g:unlocker_holder_any_test_value")
	OwlCheck  Any.is_variable("b:unlocker_holder_any_test_value")
	OwlCheck !Any.is_variable("unlocker_holder_any_test_value")
	OwlCheck !Any.is_variable(" g:unlocker_holder_any_test_value")
	OwlCheck  Any.is_variable("&incsearch")
	OwlCheck  Any.is_variable("&l:incsearch")
	OwlCheck !Any.is_variable("incsearch")
	OwlCheck !Any.is_variable("*tr")
	OwlCheck !Any.is_variable(":ls")

	unlet g:unlocker_holder_any_test_value
	unlet b:unlocker_holder_any_test_value
	OwlCheck !Any.is_variable("g:unlocker_holder_any_test_value")
	OwlCheck !Any.is_variable("b:unlocker_holder_any_test_value")
endfunction


function! s:test_is_value()
	let Any = s:Any
	OwlCheck  Any.is_value([])
	OwlCheck  Any.is_value({})
	OwlCheck !Any.is_value(0)
	OwlCheck !Any.is_value("")
endfunction

function! s:test_make()
	let Any = s:Any
	let variable = s:Variable.make("hoge")
	let dict = {}
	let value = s:Value.make(dict)

	OwlCheck Any.make("incsearch").get == variable.get
	OwlCheck Any.make("&incsearch").get == variable.get
	OwlCheck Any.make({}).get == value.get
	OwlCheck Any.make([]).get  == value.get
	OwlCheck Any.make(value) is value
	OwlCheck Any.make(value).get() is dict

	let multi = Any.make("&incsearch", {}, value, s:Holder.as_get_deepcopy(value))
	OwlCheck multi.get()[0] == &incsearch
	OwlCheck multi.get()[1] == {}
	OwlCheck multi.get()[2] is dict
	OwlCheck multi.get()[3] isnot dict

" 	echo Any.make(0)
" 	OwlThrow Any.make(0), E605
endfunction

