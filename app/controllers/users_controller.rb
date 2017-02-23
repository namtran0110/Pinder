class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new(email: params[:email])
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = "Welcome! #{@user.name}"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :image)
  end
end
