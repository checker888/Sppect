class AdminsController < ApplicationController
  before_action :admin_login_required , except:[:new,:create]
  layout'admin'
  def show
    @admin = current_admin
  end

end
