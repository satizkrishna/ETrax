class ExpenseCycle::MainExpenseCycle < ExpenseCycle

	has_many :expenses, as: :cycle

	scope :active, ->  { where(:is_active => true) }
	scope :inactive, ->  { where(:is_active => false) }

	validates :title, presence: true
	validates :owner_id, presence: true
	validates :starts_at, :expires_at, presence: true
	validates :spends, numericality: { greater_than_or_equal_to: 0 }

	def self.setup_for_user(user)
		this_cycle = new
		this_cycle.owner = user
		this_cycle.title = self.get_title_for_user(user)
		this_cycle.description = self.get_desc_for_user(user)
		this_cycle.starts_at = Time.now
		this_cycle.expires_at = user.expense_profile.get_expires_at_from_now
		this_cycle.save
		this_cycle
	end

	def self.get_title_for_user(user)
		Date.today.strftime("%B, %Y")
	end

	def self.get_desc_for_user(user)
		Date.today.strftime("%B, %Y") + 
			"---> Personal expenses for the month of " +
				Date.today.strftime("%B, %Y") +
					"---> Begins from " +
						Date.today.strftime("%a %b #{Date.today.day.ordinalize}.")
	end

	def self.get_current(user)
		current_active = user.monthly_expense_cycles.active.first
		if current_active.expires_at < Time.now
			current_active.update_attribute(:is_active,false)
			current_active = setup_for_user(user)
		end
		current_active
	end

	def self.get_all_cycles(user,options = {})
		result = user.monthly_expense_cycles.inactive
		if options[:cycle_id]
			result = result.find(options[:cycle_id])
		end
		result
	end

	def self.expenses_for_user(user)
		Expense::ForwardExpense.where(:owner_id => user.id)
	end

	def add_expense(user, params = {})
		Expense::ForwardExpense.create_for_user(user,params)		
	end

end
