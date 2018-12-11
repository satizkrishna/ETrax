class @Router

	@handlePath: (elm = null) ->
		if elm
			RouterRoutes.handle(elm.href)
		else
			RouterRoutes.handle()

