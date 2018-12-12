FactoryBot.define do
  
  factory :recoverable_expense, class: Expense::RecoverableExpense do
    
    type { "Expense::RecoverableExpense" }
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    owner_id { rand(0..10000) }
    cycle_id { rand(0..10000) }
    cycle_type { "ExpenseCycle::SharedExpenseCycle" }

    total_spends { rand(0..10000).to_f }
    expected_spends { rand(0..10000).to_f }
    recovered_spends { rand(0..10000).to_f }

    expense_type_id { rand(0..10000) }


  end

end
