FactoryGirl.define do
  factory :phase do
    name {|n| Faker::Lorem.word + n.to_s}
    program
  end

  factory :phase_with_sections, class: Phase do
    name {|n| Faker::Lorem.word + n.to_s}
    program

    after(:create) do |phase, evaluator|
      FactoryGirl.create_list(:section_with_steps, 3, phase: phase)
    end
  end
end
