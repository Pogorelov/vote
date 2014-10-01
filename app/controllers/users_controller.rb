class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:finish_signup, :process_signup]
  # after_action :verify_authorized

  def index
    @users = User.all
    authorize User
  end

  def show
    @user = User.find params[:id]
    authorize @user
  end

  def update
    @user = User.find params[:id]
    authorize @user
    if @user.update_attributes secure_params
      redirect_to users_path, notice: 'User updated.'
    else
      redirect_to users_path, alert: 'Unable to update user.'
    end
  end

  def destroy
    user = User.find params[:id]
    authorize user
    user.destroy
    redirect_to users_path, notice: 'User deleted.'
  end

  def delegate
    @user = User.find(params[:id])
    authorize @user
  end

  def finish_signup
    @user = User.new(name: session['auth']['info']['name'])
  end

  def process_signup
    auth_hash = session['auth']
    auth_hash['info']['email'] = params['user']['email']
    @user = User.find_or_create_for_omniauth(auth_hash)
    sign_in @user
    redirect_to root_url
  end

  private

  def secure_params
    params.require(:user).permit(:role, :name)
  end
end
