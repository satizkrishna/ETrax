class @RouterRoutes
	@appRoutes = null
	
	@setRoutes:  ->
		RouterRoutes.appRoutes = AppRoutes.getPathConfig()

	@handle: (crntPath = window.location.hash) ->
		location.hash = crntPath.split("#").pop()
		crntPath = crntPath.slice(1)
		RouterRoutes.setRoutes()
		for idx,path of RouterRoutes.appRoutes
			match = crntPath.match(path.regex)
			if match?
				cnt = 1
				crntParams = {}
				if path.params?
					for name in path.params
						crntParams[name.slice(1)] = match[cnt++]
				path.module.handle(crntParams)
				return false
		return NotFoundPage.handle()
