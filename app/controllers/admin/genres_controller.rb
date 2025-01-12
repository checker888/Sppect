class Admin::GenresController < Admin::Base
  def index
    @genres = Genre.all.page(params[:page]).per(10)
  end
  def new
    @genre = Genre.new()
  end
  
  def create
    @genre = Genre.new(params[:genre])
    if @genre.save
      redirect_to request.referer, notice: "ジャンルを追加しました。"
      
    else
      render "new"
    end
  end
  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to request.referer, notice: "ジャンルを削除しました。"
  end
end
