class UsersController < ApplicationController

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    @user.update( user_params )

    redirect_to conferences_path
  end

  protected

  def user_params
    params.require(:user).permit(:time_zone)
  end
  
end
