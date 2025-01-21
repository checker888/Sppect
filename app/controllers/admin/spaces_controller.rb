class Admin::SpacesController < Admin::Base
  before_action :admin_login_required
  def search
    if params[:q].present? && params[:q].to_s.length >= 16
      flash[:notice] = "キーワードが長すぎます。"
      render "index" 
    else
      if params[:owner_id] && current_owner
        @owner = Owner.find(params[:owner_id])
        @spaces = @owner.spaces.page(params[:page]).per(3)
      else
        @spaces = Space.where(approval: true,available: true).page(params[:page]).per(3)
      end
      syear =params["available_start_time(1i)"].to_i
      smonth = params["available_start_time(2i)"].to_i
      sday = params["available_start_time(3i)"].to_i
      shour = params["available_start_time(4i)"].to_i
      sminute = params["available_start_time(5i)"].to_i
      
      eyear= params["available_end_time(1i)"].to_i
      emonth= params["available_end_time(2i)"].to_i
      eday = params["available_end_time(3i)"].to_i
      ehour = params["available_end_time(4i)"].to_i
      eminute = params["available_end_time(5i)"].to_i
     @start_time = DateTime.new(syear,smonth,sday,shour,sminute)
     @end_time = DateTime.new(eyear,emonth,eday,ehour,eminute)
  
      # @spaces = @spaces.search(params[:q],params[:available_start_time],params[:available_end_time])
     
      @genre_ids = params[:genre_ids]&.select(&:present?)
      @facility_ids = params[:facility_ids]&.select(&:present?)
      @spaces = @spaces.search(params[:q],@start_time,@end_time,@genre_ids,@facility_ids)
      @spaces = @spaces.where('available_end_time >= ? and ? >= available_start_time', @start_time, @end_time)
      render "index"
    end



  end

  def index
    if params[:owner_id] && current_owner
      @owner = Owner.find(params[:owner_id])
      @spaces = @owner.spaces
    else
      @spaces = Space.where(approval: true,available: true)
    end
    @spaces = @spaces.order(posted_at: :desc).page(params[:page]).per(3)
  end

  # 記事詳細
  def show
    @space = Space.find(params[:id])
    @genres = @space.genres
    @facilities = @space.facilities
    @reviews = @space.reviews
    if current_user && !current_user.review_writable_for?(@space)
      @review = current_user.reviews.find_by(space: @space)
    end
    if @reviews.present?
      ave = 0.0
      @reviews.each do |review|
        ave += review.rating
      end
      @space.average = ave/@reviews.count
     end
    @reviews = @reviews.order(posted_at: :desc).page(params[:page]).per(3)
  end


  def like
    @space = Space.find(params[:id])
    current_user.liked_spaces << @space
    redirect_to [:admin,@space], notice: "お気に入りに登録しました。"
  end
  def unlike
    @space = Space.find(params[:id])
    current_user.liked_spaces.destroy(Space.find(params[:id]))
    # redirect_to :liked_spaces,notice: "削除しました。"
    redirect_to [:admin,@space],notice: "お気に入りを取り消しました。"
  end

  def liked
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
    @spaces = @user.liked_spaces.order("likes.created_at DESC").page(params[:page]).per(15)
  end

  def awaiting_approval
    @spaces = Space.where(approval: false).page(params[:page]).per(3)
  end
  
  def new
    @space = Space.new()
  end

  # def create
  #   @space = Space.new(params[:space])
  #   @space.owner = current_owner
  #   if @space.save
  #     redirect_to :root, notice: "スペース貸出を申請しました。"
  #     # redirect_to reservations, notice: "予約を作成しました。"
  #   else
  #     render "new"
  #   end
  # end


  # def edit
  #   @owner = current_owner
  #   @space = Space.find(params[:id])
  # end

  # def update
  #   @owner = current_owner
  #   @space = Space.find(params[:id])
  #   @space.assign_attributes(params[:space])
  #   if @space.save
  #     redirect_to :root, notice: "スペース情報を更新しました。"
  #   else
  #     render "edit"
  #   end
  # end

  def destroy
    @owner = Owner.find(params[:owner_id])
    @space = @owner.spaces.find(params[:id])
    @reservations = @space.reservations.where(status: 0)
    if @reservations.present?
      flash[:notice] = "予約が残っているスペースは削除できません"
      render "show"
    else
      @space.destroy
    redirect_to :root, notice: "スペースを削除しました。"
    end
    
    
  end

  def public_available
    @space = Space.find(params[:id])
    @space.update(available: true)
    redirect_to request.referer, notice: "スペースを公開しました。"
  end
  def private_available
    @space = Space.find(params[:id])
    @space.update(available: false)
    redirect_to request.referer, notice: "スペースを非公開にしました。"
  end

  def approve
    @space = Space.find(params[:id])
    @space.update(approval: true)
    redirect_to awaiting_approval_admin_spaces_path, notice: "スペースを承認しました。"
  end
end
