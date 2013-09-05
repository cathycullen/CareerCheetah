FactoryGirl.define do
  factory :section do
    name {|n| Faker::Lorem.word + n.to_s}
    phase
  end

  factory :section_with_steps, class: Section do
    name {|n| Faker::Lorem.word + n.to_s}
    phase

    after(:create) do |section, evaluator|
      FactoryGirl.create_list(:section_step, 3, section: section)
    end
  end
end
