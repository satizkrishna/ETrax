FactoryBot.define do
  
  factory :expense_type, class: ExpenseType do

    creator_id { rand(0..10000) }
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }

  end

end
