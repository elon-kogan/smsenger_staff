class Message < ApplicationRecord
  validates :phone, :text, presence: true
end
