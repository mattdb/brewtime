# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :step do
    brew
    sequence(:name) {|n| "Step ##{n}"}
    start { 14.days.ago }
    min_length 7
    max_length 14
    actual_length nil
  end
end
