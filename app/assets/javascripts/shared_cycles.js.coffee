class @SharedCycles extends StaticPageHandler
	@content = "Oops! Nothing Here!!"
	@query = "{ \nuser{ \nshared_cycles { \nid \ntitle \description \ntotal_due \ntotal_owe \nparticipants{ \nparticipant_id \nname \n} \nshares { \ncycle_id \nshare_type \nspend \nuser_id \nshares_between{ \nid \nuname \n} \n} \n} \n \n} \n} \n"

	@getCycleList: (contentData) -> 
		final_html = ""
		cnt = 1
		if contentData.length > 0
			for cycle,data of contentData
				shares = ""
				console.log data["shares"]
				for t,share of data["shares"]
					if share["share_type"] == "Owe"
						shares += "<p class='card-text share-owe'>#{share['shares_between']['uname']} owes you #{share["spend"]} </p>"
					else if share["share_type"] == "Due"
						shares += "<p class='card-text share-due'>You owe #{share['shares_between']['uname']} #{share["spend"]}</p>"
					console.log shares
				shares = "<p class='card-text'> No Shares Yet!!" if shares == ""
				final_html += "<div class='col-xs-12 col-sm-6 col-md-4'><div class='image-flip' ontouchstart='this.classList.toggle('hover');'><div class='mainflip'><div class='frontside'><div class='card'><div class='card-body text-center'><h4 class='card-title'>#{data['title']}</h4><p class='card-text'>#{data['description']}</p><br><br><p class='card-text'>No. of Participants: #{data['participants'].length}</p><p class='card-text'>Group owes you: #{data['total_owe']}</p><p class='card-text'>You owe Group: #{data['total_due']}</p></div></div></div><div class='backside'><div class='card'><div class='card-body text-center mt-4'><h4 class='card-title'>Shares</h4><a href=#{'#shared_cycle/'+data['id']} onclick='return Router.handlePath(this)'><p class='card-title'> View Expenses</p></a>#{shares}</div></div></div></div></div></div>"
		else
			final_html = "<div class='col-md-6 offset-md-3'><h5> No Groups Yet!! </h5></div>"
		return final_html

	@generateContent: (contentData) -> 
		contentData = contentData["data"]["user"]
		reqData = []
		if contentData["shared_cycles"].length > 0 
			for sharedCycle in contentData["shared_cycles"]
				reqData.push sharedCycle
		console.log reqData
		cyclesListHtml = SharedCycles.getCycleList(reqData)
		pageContent = "<section id='groups' class='pb-5'><div class='container'><h5 class='section-title h1'>Your Groups</h5><div class='row'>" + cyclesListHtml + '</div></div></section>'
		super(pageContent) if pageContent?

	@handle: (params = []) ->
		SharedCycles.fetchAndGenerateContent(@query,SharedCycles.generateContent)

