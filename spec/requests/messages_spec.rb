# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/messages', type: :request do
  let(:valid_attributes) do
    { phone: '+972501234567', text: 'some message text' }
  end

  let(:invalid_attributes) do
    { phone: '', text: '' }
  end

  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    before { create_list(:message, 3) }

    it 'renders a successful response' do
      get messages_url, headers: valid_headers, as: :json
      expect(response).to be_ok
      expect(json_response.length).to eq(3)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Message' do
        expect do
          post messages_url,
               params: { message: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Message, :count).by(1)
      end

      it 'renders a JSON response with the new message' do
        post messages_url,
             params: { message: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to be_successful
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Message' do
        expect do
          post messages_url, params: { message: invalid_attributes }, as: :json
        end.not_to change(Message, :count)
      end

      it 'renders a JSON response with errors for the new message' do
        post messages_url,
             params: { message: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to be_unprocessable
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(json_response).to match(phone: ["can't be blank"], text: ["can't be blank"])
      end
    end
  end
end
