class @AppRoutes
	
	@pathConfig = []

	@rawPaths = 
		"home": 	HomePage
		"monthly_cycle/:id":	MonthlyCycle
		"shared_cycle/:id":	SharedCycle
		"monthly_cycles":	MonthlyCycles
		"shared_cycles":	SharedCycles
		"expense_profile":	ExpenseProfile
		"about":	About
		"/": 	HomePage
		"": 	HomePage

	@buildRegexString: (path) ->
		path.replace(/\//g, "\\/").replace(/:(\w*)/g,"(\\w*)")

	@getPathConfig:  ->
		for path,module of AppRoutes.rawPaths
			AppRoutes.pathConfig.push {
				params: path.match(/:(\w*)/g)
				regex: new RegExp(AppRoutes.buildRegexString(path))
				module: module
			}
		return AppRoutes.pathConfig