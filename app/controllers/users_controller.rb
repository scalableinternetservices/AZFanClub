class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: %i[ show ]

  def show
    
  end

  def get_poll_by_user_id
    @user = User.find(params[:id])
    p_id = @user.poll_id
    redirect_to controller: 'polls', action: 'show', id: p_id
  end

  def create
    @poll = Poll.find(params[:poll_id])
    @user = @poll.users.create(user_params)
    # @user.time_frames.create!({start_time: user_params[:start_time], end_time: user_params[:end_time], user_id: @user.id})
    #redirect_to poll_path(@poll)

    respond_to do |format|
      if @user.save
        format.html { redirect_to poll_user_path(@poll, @user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @poll }
      else
        format.html { redirect_to @poll, alert: @user.errors.full_messages }
        format.json { render json: @user.errors }
      end
    end
    @poll.touch
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
