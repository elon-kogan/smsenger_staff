# frozen_string_literal: true

class Message < ApplicationRecord
  validates :phone, :text, presence: true

  before_create :send_message

  default_scope -> { where(sent: true) }

  private

  def send_message
    self.sent = SmsSender.new(phone: phone, text: text).call
    errors.add(:base, 'Failed to send message') unless sent?
  end
end
