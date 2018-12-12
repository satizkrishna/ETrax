class ExpenseType < ApplicationRecord
	belongs_to :creator, class_name: :User 

	scope :for_user, -> (user) { where("user_id = 0 or user_id = ?",user.id) }
	
	validates :title, presence: true, uniqueness: { scope: :creator_id }

	def self.find_or_create_for_user(user,title)
		user.my_expense_types.find_or_create_by(:title => title)
	end
end
