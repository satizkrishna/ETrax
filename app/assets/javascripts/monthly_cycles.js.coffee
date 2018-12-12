class @MonthlyCycles extends StaticPageHandler
	@content = "Oops!!! Nothing here!!!"
	@query = "{ \nuser { \ncurrent_cycle { \nid \ntitle \ndescription \ntotal_spend \nexpenses { \nspends \ndescription \ntitle \nid \n} \n} \npast_cycles { \nid \ntitle \ndescription \ntotal_spend \nexpenses { \nspends \ndescription \ntitle \nid \n} \n} \n} \n} \n"
	
	@getCycleList: (contentData) -> 
		final_html = ""
		cnt = 1
		console.log contentData
		for cycle,data of contentData
			console.log data
			final_html += "<li class='list-group-item px-0'><a class='btn collapsed' data-toggle='collapse' href=#{'#cycleList' + data['id']} role='button' aria-expanded='true' aria-controls=#{'cycleList' + data['id']}>#{data['title']}<span class='mr-3'></span></a><div class='collapse' id=#{'cycleList' + data['id']}><div class='card card-body mt-2'>#{data['description']}</div></div></li>"
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
		pageContent = '<div class="container"><div class="row"><div class="col"><div class="my-5"><ul class="list-group list-group-flush">' + cyclesListHtml + '</ul></div></div></div></div>'
		super(pageContent) if pageContent?

	@handle: (params = []) ->
		MonthlyCycles.fetchAndGenerateContent(@query,MonthlyCycles.generateContent)