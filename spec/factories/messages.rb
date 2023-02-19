# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    phone { '+972501234567' }
    text { 'Some message body' }
  end
end
