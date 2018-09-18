class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def after_sign_in_path_for(*)
    if current_user.admin?
      auctions_path
    elsif current_user.bidder?
      auctions_path
    else
      new_user_session_path
    end
  end

  def edit
  end

  def update
  end

  private

  def catch_not_found
    yield
  rescue ActiveRecord::RecordNotFound
    redirect_to root_url, :flash => { :error => "Record not found." }
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:first_name,  { roles: [] },
                         :last_name, :email,
                         :password, :password_confirmation)
    end
  end
end
