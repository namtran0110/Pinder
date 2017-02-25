class MessagesController < ApplicationController
  def index
    @messages = current_user.received_messages
  end

  def new
    @message = current_user.sent_messages.build
    @friends = current_user.friends + current_user.inverse_friends
  end

  def create
    @message = current_user.sent_messages.build message_params
    if @message.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    @message = Message.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show
    @message = Message.find(params[:id])
    if @message.recipient_id == current_user.id
      @message.update_attributes(:read_at => Time.now)
    end
  end

  private

  def message_params
    params.require(:message).permit(:sender_id, :recipient_id, :subject, :body, :read_at)
  end
end


