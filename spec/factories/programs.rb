FactoryGirl.define do
  factory :program do
    name {|n| Faker::Lorem.word + "n"}
  end

  factory :program_with_multiple_empty_phases, class: Program do
    name {|n| Faker::Lorem.word + "n"}

    after(:create) do |program, evaluator|
      FactoryGirl.create_list(:phase, 3, program: program)
    end
  end

  factory :program_with_multiple_phases, class: Program do
    name {|n| Faker::Lorem.word + "n"}

    after(:create) do |program, evaluator|
      FactoryGirl.create_list(:phase_with_sections, 3, program: program)
    end
  end
end
