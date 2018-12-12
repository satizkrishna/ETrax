FactoryBot.define do
  
  factory :participant, class: Participant do

    participant_id { rand(0..10000) }
    cycle_id { rand(0..10000) }
    total_due { rand(0..1000).to_f }
    total_owe { rand(0..1000).to_f }

  end

end
