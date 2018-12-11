class ExpenseProfile < ApplicationRecord
	belongs_to :user
	validates :starts_at_day, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 31 }
	validates :funds, presence: true, numericality: { greater_than_or_equal_to: 0 }

	def self.create_for_user(user)
		create(:user_id => user.id)
	end

	def get_expires_at_from_now
		ex_t = Date.today.at_beginning_of_month.next_month
		next_month_max = Time.days_in_month(ex_t.month, ex_t.year)
		next_cycle_starts_at = Date.civil(ex_t.year,ex_t.month,[next_month_max,starts_at_day].min)
		next_cycle_starts_at - 1.second
	end
end
