class UsersController < ApplicationController
    def create
        @poll = Poll.find(params[:poll_id])
        @user = @poll.users.create!(user_params)
        redirect_to poll_path(@poll)
      end

    def user_params
      time_frame_params = [params.permit(time_frames: [:start_time, :end_time])[:time_frames]]
      p time_frame_params
      {name: params[:user][:name], time_frames_attributes: time_frame_params}
    end
end
