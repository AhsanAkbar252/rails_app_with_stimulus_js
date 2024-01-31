FactoryBot.define do
  factory :skill do
    name { "MyString" }
    type { "" }
  end

  factory :front_end_skill do
    name { 'HTML' }
  end

  factory :back_end_skill do
    name {'Ruby'}
  end
end
