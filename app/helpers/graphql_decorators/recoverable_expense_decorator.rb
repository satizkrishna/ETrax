module GraphqlDecorators
	class RecoverableExpenseDecorator < SharedExpenseDecorator

		def paid_by
			@object.owner.uname
		end

		def total_spend
			@object.total_spends + @object.expected_spends
		end

		def my_spend
			@object.total_spends
		end

		def share_type
			"Owe"
		end

	end
end