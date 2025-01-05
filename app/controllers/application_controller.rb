class ApplicationController < ActionController::Base
  private def current_user
    User.find_by(id: cookies.signed[:user_id]) if cookies.signed[:user_id]
  end
  helper_method :current_user

  private def current_owner
    Owner.find_by(id: cookies.signed[:owner_id]) if cookies.signed[:owner_id]
  end
  helper_method :current_owner
  
  def cookies_signed_func(value)
    cookies.signed[:user_id] = {
      value: value,
      expires: 1.day.from_now
    }
  end

  private def update_expiration_time
    if current_user
      cookies_signed_func(cookies.signed[:user_id])
    end
  end

  private def login_required
    raise LoginRequired unless current_user
  end
end
