class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]

  def edit
    @sports = Sport.all
  end

  def show
    # user already set before action
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id]) || current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :location, :profile_picture, :country_code, :phone_number, sport_ids: [])
  end
end
