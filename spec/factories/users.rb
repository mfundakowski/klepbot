# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'first_name' }
    last_name { 'last_name' }
    email { 'user@example.com' }
    password { 'password' }
  end
end
