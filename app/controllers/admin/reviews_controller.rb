class Admin::ReviewsController < Admin::Base
  before_action :admin_login_required 
  def destroy
    @space = Space.find(params[:space_id])
    @review = @space.reviews.find_by_id(params[:id])
    if @review.present?
      @review.destroy
      redirect_to :admin_root, notice: "レビューを削除しました。"
    else
      redirect_to :admin_root, notice: "レビューがすでに存在しません。"
    end
    
  end


end
