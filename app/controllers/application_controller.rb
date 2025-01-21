class ApplicationController < ActionController::Base
  private def current_user
    User.find_by(id: cookies.signed[:user_id]) if cookies.signed[:user_id]
  end
  helper_method :current_user

  private def current_owner
    Owner.find_by(id: cookies.signed[:owner_id]) if cookies.signed[:owner_id]
  end
  helper_method :current_owner

  private def current_admin
    Admin.find_by(id: cookies.signed[:admin_id]) if cookies.signed[:admin_id]
  end
  helper_method :current_admin
  
  def user_cookies_signed_func(value)
    cookies.signed[:user_id] = {
      value: value,
      expires: 1.day.from_now
    }
  end
  def owner_cookies_signed_func(value)
    cookies.signed[:owner_id] = {
      value: value,
      expires: 1.day.from_now
    }
  end
  def admin_cookies_signed_func(value)
    cookies.signed[:admin_id] = {
      value: value,
      expires: 1.day.from_now
    }
  end

  private def update_expiration_time
    if current_user
      user_cookies_signed_func(cookies.signed[:user_id])
    elsif current_owner
      owner_cookies_signed_func(cookies.signed[:owner_id])
    elsif current_admin
      admin_cookies_signed_func(cookies.signed[:admin_id])
    end
  end

  private def login_required
    if !current_user
      raise LoginRequired
    end
  end

  private def owner_login_required
    if !current_owner
      raise OwnerLoginRequired
    end
  end

 

  class OwnerLoginRequired < StandardError; end
  class LoginRequired < StandardError; end
  class Forbidden < StandardError; end

  if Rails.env.production? || ENV["RESCUE_EXCEPTIONS"]
    rescue_from StandardError, with: :rescue_internal_server_error
    rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found
    rescue_from ActionController::ParameterMissing, with: :rescue_bad_request
  end
  private def rescue_login_required(exception)
    render "login/index", status: 403,
      formats: [:html]
  end
  private def rescue_owner_login_required(exception)
    render "login/index", status: 403,
      formats: [:html]
  end
  private def rescue_forbidden(exception)
    render "login/index", status: 403,
      formats: [:html]
  end
  rescue_from OwnerLoginRequired, with: :rescue_owner_login_required
  rescue_from LoginRequired, with: :rescue_login_required
  rescue_from Forbidden, with: :rescue_forbidden
end
