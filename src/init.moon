module.preinit=() ->
	print "preinit"
	print "Name: #{module.name}"
	print "Version: #{module.version}"
	print "Respath: #{module.respath}"

module.init=() ->
	print "init"
	for mod, ver in module.loaded!
		print "Found module #{mod} verision #{ver}"

print "load"
