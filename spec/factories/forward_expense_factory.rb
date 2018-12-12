FactoryBot.define do
  
  factory :forward_expense, class: Expense::ForwardExpense do
    
    type { "Expense::ForwardExpense" }
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    owner_id { rand(0..10000) }
    cycle_id { rand(0..10000) }
    cycle_type { "ExpenseCycle::MainExpenseCycle" }

    total_spends{ rand(0..10000).to_f }

    expense_type_id { rand(0..10000) }

  end

end
