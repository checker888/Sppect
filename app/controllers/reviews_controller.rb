class ReviewsController < ApplicationController
  def new 
    @review = Review.new(posted_at: Time.current)
    @space = Space.find(params[:space_id])
  end

  def index
    @reviews = Review.all.page(params[:page]).per(3);
  end
  def create
    @review = Review.new(params[:review])
    @review.user = current_user
    @review.space = Space.find(params[:space_id])
    if @review.save
      redirect_to :root, notice: "レビューを投稿しました。"
      
    else
      render "new"
    end
  end

  def edit
    @space = Space.find(params[:space_id])
    @review = current_user.reviews.find_by(space: @space)
  end

  def update
    @space = Space.find(params[:space_id])
    @review = current_user.reviews.find_by(space: @space)
    @review.assign_attributes(params[:review])
    if @review.save
      redirect_to :root, notice: "レビューを更新しました。"
    else
      render "edit"
    end
  end
  def destroy
    @review = current_user.reviews.find(params[:id])
    @review.destroy
    redirect_to :root, notice: "レビューを削除しました。"
  end


end
