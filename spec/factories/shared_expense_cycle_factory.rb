FactoryBot.define do
  
  factory :shared_expense_cycle, class: ExpenseCycle::SharedExpenseCycle do
    
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    type { "ExpenseCycle::SharedExpenseCycle" }
    owner_id { rand(1..10000) }

  end

end
