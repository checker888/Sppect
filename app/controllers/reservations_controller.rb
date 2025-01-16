class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new()
    @space = Space.find(params[:space_id])
  end

  def index
    @reservations = Reservation.all.page(params[:page]).per(3);
  end

  def create
    @reservation = Reservation.new(params[:reservation])
    @reservations = Reservation.where('space_id = ? and reserve_end_time > ? and ? > reserve_start_time', params[:space_id] ,@reservation.reserve_start_time, @reservation.reserve_end_time)
    if @reservations.present?
      flash.notice = "その時間には既に予約が登録されています。"
      render "new"
    else
      @reservation.user = current_user
      @reservation.space = Space.find(params[:space_id])
      if @reservation.save
        redirect_to :root, notice: "予約が完了しました。"
        # redirect_to reservations, notice: "予約を作成しました。"
      else
        render "new"
      end
    end

  end

  def edit
    @space = Space.find(params[:space_id])
    @reservation = current_user.reservations.find_by(space: @space)
   
  end

  def update
    @space = Space.find(params[:space_id])
    @reservation = current_user.reservations.find_by(space: @space)
    @reservation.assign_attributes(params[:reservation])
    if @reservation.save
      redirect_to :root, notice: "予約内容を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @space = Space.find(params[:space_id])
    @reservation = current_user.reservations.find_by(space: @space)
    @reservation.destroy
    redirect_to :root, notice: "予約を削除しました。"
  end
end
