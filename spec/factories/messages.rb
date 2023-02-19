FactoryBot.define do
  factory :message do
    phone { '+972501234567' }
    text { 'Some message body' }
  end
end
