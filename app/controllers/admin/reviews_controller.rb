class Admin::ReviewsController < Admin::Base
  def destroy
    @space = Space.find(params[:space_id])
    @review = @space.reviews.find(params[:id])
    @review.destroy
    redirect_to :admin_root, notice: "レビューを削除しました。"
  end


end
