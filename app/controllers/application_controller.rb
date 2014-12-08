class ApplicationController < ActionController::Base
  before_action :require_login

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.find_by(id: session[:user_id])
  end

  def require_login
    unless current_user
      redirect_to signin_path, notice: 'You must be logged in to access that action'
    end
  end

  def ensure_membership
    unless @project.memberships.find_by(:user => current_user)
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

  def ensure_ownership
    unless current_user.owner?(@project)
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end

  helper_method :current_user, :ensure_membership

end
