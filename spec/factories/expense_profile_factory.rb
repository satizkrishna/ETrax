FactoryBot.define do
  
  factory :expense_profile, class: ExpenseProfile do
    
    starts_at_day { rand(1..31) }
    funds { rand(0..10000).to_f }
    user_id { rand(0..10000) }
    can_alert { rand(0..1).zero? }


    trait :overflowing_starts_at_day do
      starts_at_day { rand(41..100) }
    end

    trait :negative_funds do
      funds { (-1) * rand(0..10000).to_f }
    end


  end

end
