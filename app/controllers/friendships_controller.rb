class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to root_url
    else
      flash[:error] = "Unable to add friend."
      redirect_to root_url
    end
  end

  def destroy
    Friendship.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Removed friendship' }
      format.json { head :no_content }
    end
  end
end
