class ExpenseProfile < ApplicationRecord
	belongs_to :user
	validates :starts_at_day, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 31 }
	validates :funds, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
