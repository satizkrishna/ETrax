module GraphqlDecorators
	class PendingExpenseDecorator < SharedExpenseDecorator

		def paid_by
			@object.parent.owner.uname
		end

		def total_spend
			@object.total_spends
		end

		def my_spend
			@object.expected_spends
		end

		def share_type
			"Due"
		end

	end
end