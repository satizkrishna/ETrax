class @RouterRoutes
	@appRoutes = null
	
	@setRoutes:  ->
		RouterRoutes.appRoutes = AppRoutes.getPathConfig()

	@handle: (crntPath = window.location.hash) ->
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
				return path.module.handle(crntParams)
		return NotFoundPage.handle()
