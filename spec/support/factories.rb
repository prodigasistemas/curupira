require 'factory_girl_rails'

FactoryGirl.define do
  factory :user do
    sequence(:name)     { |n| "User #{n}" }
    sequence(:email)    { |n| "email#{n}@curupira.com" }
    sequence(:username) { |n| "user_#{n}" }
    password 12345678
    active true
  end

  factory :group do
    sequence(:name) { |n| "Group #{n}" }
    active true
  end

  factory :group_user do
    group
    user
  end

  factory :feature do
    name  "Leitura"
    active true
  end 

  factory :service do
    name "users"
  end

  factory :action_label do
    name "new"
  end

  factory :feature_service do
    feature
    service
  end

  factory :feature_action_label do
    feature
    action_label
  end
  
  factory :role do
    sequence(:name)     { |n| "Role #{n}" }
    active true
  end

  factory :authorization do
    role
    feature
  end

  factory :role_group do
    group
    role
  end

  factory :role_group_user do
    group_user
    role
  end
end
