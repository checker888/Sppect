class Admin::GenresController < Admin::Base
  before_action :admin_login_required 
  def index
    @genres = Genre.all.page(params[:page]).per(10)
  end
  def new
    @genre = Genre.new()
  end
  
  def create
    @genre = Genre.new(params[:genre])
    gc = Genre.find_by(name: @genre.name)
    if @genre.save && !gc.present?
      redirect_to request.referer, notice: "ジャンルを追加しました。"
      
    else
      render "new"
    end
  end
  def destroy
    
    # @genre = Genre.where(id: params[:id])
    @genre = Genre.find(params[:id])
    @spaces = Space.includes(:genres).where(genres: {id: @genre.id})
    if @spaces.present?
      @spaces.each do |space|
        space.genre_ids =  1
      end
      # @genre.spaces.each do |space|
      #   space.update_all(genres: Genre.find_by(name: "その他"))
      #   order = Order.includes(:customers).where(customer: { id: 1 })

      # end
      # @genre.spaces.genres =  Genre.find_by(name: "その他")
      # @spaces.includes(:genres).update_all(genres: Genre.find_by(name: "その他"))
    end


  @genre.destroy
    redirect_to request.referer, notice: "ジャンルを削除しました。"
  end
end
