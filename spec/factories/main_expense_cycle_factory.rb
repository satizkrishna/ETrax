FactoryBot.define do
  
  factory :main_expense_cycle, class: ExpenseCycle::MainExpenseCycle do
    
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    type { "ExpenseCycle::MainExpenseCycle" }
    owner_id { rand(1..10000) }
    starts_at { Date.today - Faker::Number.number(1).to_i.days }
    expires_at { Date.today + Faker::Number.number(1).to_i.days }
    spends { 0 }
    is_active { true }

  end

end
