class TimeFramesController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
        @poll = Poll.find(params[:poll_id])
        @user = User.find(params[:user_id])
        @time_frame = @user.time_frames.create({start_time: time_frame_params[:start_time], end_time: time_frame_params[:end_time], user_id: @user.id, tier: time_frame_params[:tier]})
        #redirect_to poll_user_path(@poll, @user)
        respond_to do |format|
            if @time_frame.save
              format.html { redirect_to poll_user_path(@poll, @user) , notice: "Time frame successfully created." }
              format.json { render :show, status: :created, location: @user }
            else
              format.html { redirect_to poll_user_path(@poll, @user), alert: @time_frame.errors.full_messages }
              format.json { render json: @time_frame.errors }
            end
          end
        @poll.touch
        @user.touch
    end

    def time_frame_params
        params.require(:time_frame).permit(:start_time, :end_time, :tier)
    end
end
