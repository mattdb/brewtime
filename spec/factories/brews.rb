# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :brew do
    name "Honey Hibiscus Vanilla Oaked Russian Imperial Black Belgian Ale"
    brewed "2012-08-08"
    
    factory :brew_with_steps do
      ignore do
        steps_count 3
      end
      
      after(:create) do |brew, evaluator|
        FactoryGirl.create_list(:step, evaluator.steps_count, brew: brew)
      end
    end
  end
end
