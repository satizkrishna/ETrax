class @StaticPageHandler
	@content = null
	@query = null

	@generateContent: (contentData) -> 
		StaticPageHandler.content = contentData if contentData?
		StaticPageHandler.render()
	
	
	@fetchAndGenerateContent: (query = "",callback) ->
		if query? && query != ""
			responseData = null
			token = (xhr) ->
				xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
				return
			$.ajax
				method: 'post'
				url: 'http://localhost:3000/graphql?'
				data: JSON.stringify({query: query})
				beforeSend: token,
				headers:
					'Content-Type': 'application/json'
					'X-CSRF-Token': xcsrf
				success: (data) ->
					callback(data)
				error: (err) ->
					throw err
					return false
	
	@handle: (params = []) ->
		StaticPageHandler.fetchAndGenerateContent(@query,StaticPageHandler.generateContent)
	
	@render: ->
		mainDiv = document.getElementById('main-body')
		mainDiv.innerHTML = StaticPageHandler.content