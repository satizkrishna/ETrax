class GraphqlDecorators::ParticipantDecorator < GraphqlDecorator

	def name
		@object.user.uname
	end

end