# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SmsSender, type: :service do
  describe '#call' do
    subject(:call) { service.call }

    let(:attributes) { { phone: '+972501234567', text: 'some message text' } }
    let(:service) { described_class.new(**attributes) }

    context 'when twilio responds ok' do
      before { allow(service).to receive(:send_sms) }

      it { is_expected.to be_truthy }
    end

    context 'when twilio responds error' do
      before do
        allow(service).to receive(:send_sms).and_raise(Twilio::REST::TwilioError,
                                                       'Page Records can not be deserialized')
      end

      it { is_expected.to be_falsey }
    end

    context 'when twilio responds unexpected error' do
      let(:unexpected_error) { ZeroDivisionError }

      before { allow(service).to receive(:send_sms).and_raise(unexpected_error) }

      it 'raises unexpected error' do
        expect { call }.to raise_error(unexpected_error)
      end
    end
  end
end
