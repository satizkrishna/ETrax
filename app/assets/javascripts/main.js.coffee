$(document).ready ->
	if current_user?
		Router.handlePath()
	else
		alert "Please Log in to continue!!!"
