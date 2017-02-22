class MessagesController < ApplicationController
  def index
    @messages = current_user.received_messages
  end

  def new
    @message = current_user.sent_messages.build
  end

  def create
    @message = current_user.sent_messages.build message_params
    if @message.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def message_params
    params.require(:message).permit(:sender_id, :recipient_id, :subject, :body)
  end
end


