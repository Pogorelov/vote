# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :identity do
    voter nil
    provider "MyString"
    uid "MyString"
  end
end
