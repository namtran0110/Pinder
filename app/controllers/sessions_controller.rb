class SessionsController < ApplicationController
  def new
  end

  def create
    if @user = User.find_by(email: params[:email])
      if @user.authenticate(params[:password])
        flash[:success] = "Signed In Successfully"
        session[:user_id] = @user.id
        redirect_to(root_path)
      else
        flash.now[:error] = "Wrong Password"
        render 'new'
      end
    else
      flash.now[:error] = "User not found"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, flash: {success: "Logged out"}
  end
end
