class @MonthlyCycle extends StaticPageHandler
	@content = "Oops!! Nothing Here!!!"
	@query = "{\nmonthly_cycle(cycle_id: $cycle_id) {\nid\ntitle\ntotal_spend\nstarts_at\nexpires_at\nexpenses {\nid\ntitle\ndescription\nspends\ncreated_at\n}\n}\n}\n"

	@getQuery: (params) ->
		return MonthlyCycle.query.replace('$cycle_id',params["id"])

	@getExpenseList: (contentData) -> 
		final_html = ""
		cnt = 1
		for cycle,data of contentData
			console.log data
			final_html += "<li><div class='tl-badge danger'>#{data['created_at']}</div><div class='tl-panel'><div class='tl-heading'><h4 class='tl-title'>#{data['title']}</h4></div><div class='tl-body'><p class='mnth-timeline-desc'>#{data['description']}</p><p class='mnth-timeline-sp'>#{data['spends']}</p></div></div></li>"
		return final_html

	@generateContent: (contentData) -> 
		contentData = contentData["data"]["monthly_cycle"]
		reqData = []
		if contentData["expenses"].length > 0 
			for expense in contentData["expenses"]
				reqData.push expense
			cyclesListHtml = MonthlyCycle.getExpenseList(reqData)
			pageContent = "<div class='container mt-5 mb-5'><div class='row'><div class='col-md-6 offset-md-3'><h4>Your Expenses for the cycle #{contentData['title']}</h4><h5 class='mnth-timeline-sp'>Your Total Expenses:  #{contentData['total_spend']}</h5><ul class='tl'>" + cyclesListHtml + '</ul></div></div></div>'
		else
			pageContent = "<div class='container mt-5 mb-5'><div class='row'><div class='col-md-6 offset-md-3'><h4>Your Expenses for the cycle #{contentData['title']}</h4><h5 class='mnth-timeline-sp'>Your Total Expenses:  #{contentData['total_spend']}</h5>" + "<h6>No Expenses Yet!!!</h6>" + '</div></div></div>'
		super(pageContent) if pageContent?

	@handle: (params = []) ->
		if params["id"]?
			query = MonthlyCycle.getQuery(params)
		else
			return false
		MonthlyCycle.fetchAndGenerateContent(query,MonthlyCycle.generateContent)

