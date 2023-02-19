# frozen_string_literal: true

class SmsSender
  def initialize(phone:, text:)
    @phone = phone
    @text = text
  end

  def call
    send_sms
    true
  rescue Twilio::REST::TwilioError
    false
  end

  private

  attr_reader :phone, :text

  def send_sms
    client.messages.create(
      from: ENV.fetch('SMSENGER_STAFF_TWILIO_SENDER', nil),
      to: phone,
      body: text
    )
  end

  def client
    @client ||= Twilio::REST::Client.new ENV.fetch('SMSENGER_STAFF_TWILIO_SID'),
                                         ENV.fetch('SMSENGER_STAFF_TWILIO_TOKEN')
  end
end
