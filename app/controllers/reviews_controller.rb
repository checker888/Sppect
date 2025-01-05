class ReviewsController < ApplicationController
  def new 
    @review = Review.new()
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
      redirect_to :root, notice: "予約が完了しました。。"
      # redirect_to reservations, notice: "予約を作成しました。"
    else
      render "new"
    end
  end
end
