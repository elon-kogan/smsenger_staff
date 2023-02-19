# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message, type: :model do
  it { is_expected.to validate_presence_of(:phone) }
  it { is_expected.to validate_presence_of(:text) }
end
