class HomeController < ApplicationController
	before_action :authenticate_user!
	def index
		Rails.logger.debug "SUmma"
	end
end