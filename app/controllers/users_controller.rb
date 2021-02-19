class UsersController < ApplicationController
  before_action :set_user, only: %i[ show ]

  def show
    
  end

  def create
    @poll = Poll.find(params[:poll_id])
    @user = @poll.users.create!(user_params)
    # @user.time_frames.create!({start_time: user_params[:start_time], end_time: user_params[:end_time], user_id: @user.id})
    redirect_to poll_path(@poll)
  end

  def user_params
    # time_frame_params = [params.permit(time_frames: [:start_time, :end_time])[:time_frames]]
    # p time_frame_params
    # {name: params[:user][:name], start_time: params[:time_frames][:start_time], end_time: params[:time_frames][:end_time]}
    params.require(:user).permit(:name)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      @poll = Poll.find(params[:poll_id])
    end
end
