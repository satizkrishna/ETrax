class @MonthlyCycles extends StaticPageHandler
	@content = "Oops!!! Nothing here!!!"
	@query = "{ \nuser { \ncurrent_cycle { \nid \ntitle \ndescription \ntotal_spend \nexpenses { \nspends \ndescription \ntitle \nid \n} \n} \npast_cycles { \nid \ntitle \ndescription \ntotal_spend \nexpenses { \nspends \ndescription \ntitle \nid \n} \n} \n} \n} \n"
	
	@getCycleList: (contentData) -> 
		final_html = ""
		cnt = 1
		console.log contentData
		for cycle,data of contentData
			console.log data
			final_html += "<li><a class='mnth-timeline-a' href=#{'#monthly_cycle/'+data['id']} onclick='return Router.handlePath(this)'>#{data['title']}</a><p class='mnth-timeline-sp'>Spends: #{data['total_spend']}</p><p class='mnth-timeline-desc'>#{data['description']}</p></li>"
		return final_html

	@generateContent: (contentData) -> 
		contentData = contentData["data"]["user"]
		reqData = []
		reqData.push contentData["current_cycle"]
		if contentData["past_cycles"].length > 0 
			for pastCycle in contentData["past_cycles"]
				reqData.push pastCycle
		console.log reqData
		cyclesListHtml = MonthlyCycles.getCycleList(reqData)
		pageContent = '<div class="container mt-5 mb-5"><div class="row"><div class="col-md-6 offset-md-3"><h4>Your Monthly Cycles</h4><ul class="timeline">' + cyclesListHtml + '</ul></div></div></div>'
		super(pageContent) if pageContent?

	@handle: (params = []) ->
		MonthlyCycles.fetchAndGenerateContent(@query,MonthlyCycles.generateContent)

