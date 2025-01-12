class Admin::FacilitiesController < Admin::Base
  def index
    @facilities = Facility.all.page(params[:page]).per(10)
  end
  def new
    @facility = Facility.new()
  end
  
  def create
    @facility = Facility.new(params[:facility])
    if @facility.save
      redirect_to request.referer, notice: "設備を追加しました。"
      
    else
      render "new"
    end
  end
  def destroy
    @facility = Facility.find(params[:id])
    @facility.destroy
    redirect_to request.referer, notice: "設備を削除しました。"
  end
end
