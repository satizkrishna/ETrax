class ExpenseType < ApplicationRecord
	belongs_to :creator, class_name: :User 

	
	validates :title, presence: true, uniqueness: { scope: :creator_id }
end
