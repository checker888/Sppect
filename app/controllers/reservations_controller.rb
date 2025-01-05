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
    @reservation.user = current_user
    @reservation.space = Space.find(params[:space_id])
    if @reservation.save
      redirect_to :root, notice: "予約が完了しました。。"
      # redirect_to reservations, notice: "予約を作成しました。"
    else
      render "new"
    end
  end

end
