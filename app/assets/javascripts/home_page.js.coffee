class @HomePage
	@props= ""

	@handle: ->
		alert("Home")
		mainDiv = document.getElementById('main-body')
		mainDiv.innerHTML += '<h1> WELCOME HOME </h1>'