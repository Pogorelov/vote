class UserPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def edit?
    @current_user.admin? or @current_user == @user
  end

  def index?
    @current_user and @current_user.admin?
  end

  def show?
    # @current_user.admin? or @current_user == @user
    @current_user
  end

  def update?
    @current_user.admin?
  end

  def destroy?
    @current_user != @user and @current_user.admin?
  end

  def delegate?
    @current_user.admin? or @current_user == @user
  end
end
