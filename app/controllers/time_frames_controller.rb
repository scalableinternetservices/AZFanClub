class TimeFramesController < ApplicationController
    def create
        @poll = Poll.find(params[:poll_id])
        @user = User.find(params[:user_id])
        @user.time_frames.create!({start_time: params[:time_frame][:start_time], end_time: params[:time_frame][:end_time], user_id: @user.id})
        redirect_to poll_user_path(@poll, @user)
    end
end
