# frozen_string_literal: true

class MessagesController < ApplicationController
  # GET /messages
  def index
    @messages = Message.all

    render json: @messages
  end

  # POST /messages
  def create
    @message = Message.new(message_params)

    if @message.save
      if @message.sent?
        render json: @message, status: :created
      else
        render json: @message.errors.full_messages, status: :bad_request
      end
    else
      render json: @message.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:phone, :text)
  end
end
