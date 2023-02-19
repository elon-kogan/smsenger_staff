# frozen_string_literal: true

shared_context 'when sms is sent' do
  let(:message_attributes) { { phone: '123', text: 'some text' } }
  let(:sms_sender) { instance_double(SmsSender) }
  let(:sender_response) { true }

  before do
    allow(SmsSender).to receive(:new).with(any_args).and_return(sms_sender)
    allow(sms_sender).to receive(:call).and_return(sender_response)
  end
end
