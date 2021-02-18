class UsersController < ApplicationController
    def create
        @poll = Poll.find(params[:poll_id])
        @user = @poll.users.create(user_params)
        redirect_to poll_path(@poll)
      end

    def user_params
      params.require(:user).permit(:name, :time_frames_attributes => [:start_time, :end_time] )
    end
end
