class Admin::StadiumsController < ApplicationController

  before_action :correct_user


  def create
    @stadium = Stadium.new(stadium_params)
    @club = Club.find(params[:stadium][:club_id])
    @stadium.club_id = @club.id
    if @stadium.save
      redirect_to admin_stadiums_path
    else
      @q = Stadium.ransack(params[:q])
      @stadiums = @q.result.page(params[:page])
      render :index
    end
  end

  def index
    @q = Stadium.ransack(params[:q])
    @stadiums = @q.result.page(params[:page])
    @stadium = Stadium.new
  end

  def show
    @stadium = Stadium.find(params[:id])
    @posts = @stadium.posts.page(params[:page]).order(created_at: "DESC")
  end

  def edit
    @stadium = Stadium.find(params[:id])
  end

  def update
    @stadium = Stadium.find(params[:id])
    if @stadium.update(stadium_params)
      redirect_to admin_stadium_path(@stadium)
    else
      render :edit
    end
  end

  private
  def stadium_params
    params.require(:stadium).permit(:name, :club_id)
  end

  def correct_user
    if admin_signed_in?
    else
      redirect_to root_path
    end
  end
end
