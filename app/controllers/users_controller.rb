class UsersController < ApplicationController
  def create
    if params[:user][:password] == params[:user][:password_confirmation]
      new_user = User.create(user_params)
      
    else
      flash[:errors] = ["Passwords do not match"]
        redirect_to :back
    end
      
    if new_user
      if new_user.valid?
        session[:user_id] = new_user.id
        redirect_to "/events"
      else
        flash[:errors] = new_user.errors.full_messages
        redirect_to :back
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :city, :state, :password)
  end
end
