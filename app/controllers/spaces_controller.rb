class SpacesController < ApplicationController

  def index
    if params[:member_id]
      @owner = Owner.find(params[:owner_id])
      @spaces = @owner.spaces
    else
      @spaces = Space.all
    end

    @spaces = @spaces.order(posted_at: :desc).page(params[:page]).per(3)
  end

end
