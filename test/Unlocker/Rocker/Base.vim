call vital#of("vital").unload()
let s:Base = vital#of("vital").import("Unlocker.Rocker.Base")


function! s:test_has_concept_locker()
	let Rocker = s:Base
	OwlCheck !Rocker.has_concept_locker(0)
	OwlCheck !Rocker.has_concept_locker("")
	OwlCheck !Rocker.has_concept_locker([])
	OwlCheck !Rocker.has_concept_locker({})
	OwlCheck !Rocker.has_concept_locker({ "get" : 42 })
	OwlCheck !Rocker.has_concept_locker({ "set" : 42 })
	OwlCheck !Rocker.has_concept_locker({ "set" : 42, "get" : 42 })
	OwlCheck !Rocker.has_concept_locker({ "set" : 42, "get" : function("tr") })
	OwlCheck !Rocker.has_concept_locker({ "get" : 42, "set" : function("tr") })

	OwlCheck Rocker.has_concept_locker({ "get" : function("tr"), "set" : function("tr") })
endfunction

