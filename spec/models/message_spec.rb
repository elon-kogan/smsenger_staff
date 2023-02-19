# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message do
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to validate_presence_of(:text) }

  describe '#create' do
    subject { described_class.create(attributes_for(:message)) }

    include_context 'when sms is sent'

    context 'when sms sent successfully' do
      let(:sender_response) { true }

      it { is_expected.to be_sent }
    end

    context 'when sms sending was failed' do
      let(:sender_response) { false }

      it { is_expected.not_to be_sent }
    end
  end
end
