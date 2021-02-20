class TimeFramesController < ApplicationController
    def create
        @poll = Poll.find(params[:poll_id])
        @user = User.find(params[:user_id])
        
        @user.time_frames.create!({start_time: time_frame_params[:start_time], end_time: time_frame_params[:end_time], user_id: @user.id})
        redirect_to poll_user_path(@poll, @user)
    end

    def time_frame_params
        params.require(:time_frame).permit(:start_time, :end_time)
    end
end
