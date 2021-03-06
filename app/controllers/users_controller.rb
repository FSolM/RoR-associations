# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      sign_in(user)
      flash[:notice] = 'User created succesfully'
      redirect_to root_path
    else
      flash[:warning] = 'There has been an error crating your user please try again later'
      redirect_to new_user_path
    end
  end

  def show
    @user = User.find(params[:id])
    @events = Event.where(creator: @user)
    @date = Date.current
    @upcomming_events = @user.created_events.upcomming_events
    @previous_events = @user.created_events.previous_events
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
