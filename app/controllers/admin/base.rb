class Admin::Base < ApplicationController

  private def admin_login_required
    raise Forbidden unless current_admin&.present?
  end

  # private def current_admin
  #   Admin.find_by(id: cookies.signed[:admin_id]) if cookies.signed[:admin_id]
  # end
  # helper_method :current_admin
end