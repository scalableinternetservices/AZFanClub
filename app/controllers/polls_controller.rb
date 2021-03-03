class PollsController < ApplicationController
  include PollsHelper
  skip_before_action :verify_authenticity_token
  before_action :set_poll, only: %i[ show edit update destroy ]

  # GET /polls or /polls.json
  def index
    @polls = Poll.all
  end

  # GET /polls/1 or /polls/1.json
  def show
    logger.debug "PRINTING ID " + @poll.id
    find_optimal_times()
  end

  # GET /polls/new
  def new
    @poll = Poll.new
  end

  # GET /polls/1/edit
  def edit
  end

  # POST /polls or /polls.json
  def create
    @poll = Poll.new(poll_params)

    respond_to do |format|
      if @poll.save
        format.html { redirect_to @poll, notice: "Poll was successfully created." }
        format.json { render :show, status: :created, location: @poll }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /polls/1 or /polls/1.json
  def update
    respond_to do |format|
      if @poll.update(poll_params)
        format.html { redirect_to @poll, notice: "Poll was successfully updated." }
        format.json { render :show, status: :ok, location: @poll }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /polls/1 or /polls/1.json
  def destroy
    @poll.destroy
    respond_to do |format|
      format.html { redirect_to polls_url, notice: "Poll was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    TimeSlotInfo = Struct.new(:count, :penalty) 

    # Use callbacks to share common setup or constraints between actions.
    def set_poll
      @poll = Poll.find(params[:id])
      @optimal_times = []
    end

    # Only allow a list of trusted parameters through.
    def poll_params
      poll_params = params.require(:poll).permit(:title, :timeframe_start, :timeframe_end, "daily_start(4i)", "daily_end(4i)")
      poll_params[:daily_start] = poll_params["daily_start(4i)"].to_i
      poll_params[:daily_end] = poll_params["daily_end(4i)"].to_i
      poll_params.delete("daily_start(4i)")
      poll_params.delete("daily_end(4i)")
      poll_params[:timeframe_start] = tryParseDatetime(poll_params[:timeframe_start])
      poll_params[:timeframe_end] = tryParseDatetime(poll_params[:timeframe_end], end_of_day: true)
      
      return poll_params
    end

    def find_optimal_times
      users = @poll.users
      increment = 15*60

      time_slot_user_counts = {}

      users.each do |user|
        user.time_frames.each do |time_frame|
          start_time = time_frame.start_time
          # logger.debug "START BEFORE ROUND " + start_time.to_s
          start_time = Time.at((start_time.to_r / increment).ceil * increment)
          # logger.debug "START AFTER ROUND " + start_time.to_s
          end_time = time_frame.end_time
          # logger.debug "END BEFORE ROUND " + end_time.to_s
          end_time = Time.at((end_time.to_r / increment).floor * increment)
          # logger.debug "END AFTER ROUND " + end_time.to_s

          cur_time = start_time

          while cur_time < end_time do 
            if time_slot_user_counts[cur_time].nil?
              time_slot_user_counts[cur_time] = TimeSlotInfo.new(1, time_frame.tier ** 2)
            else
              time_slot_user_counts[cur_time].count += 1
              time_slot_user_counts[cur_time].penalty += time_frame.tier ** 2
            end
            cur_time += increment
          end
        end
        
        # logger.debug "PRINTING USER " + user.name
      end
      # logger.debug "USER COUNTS " + time_slot_user_counts.to_s

      max_count = 0
      optimal_times = {}

      time_slot_user_counts.each do |time_slot, info|
        if info.count > max_count
          optimal_times.clear()
          max_count = info.count
          optimal_times[time_slot] = info.penalty
        elsif info.count == max_count
          optimal_times[time_slot] = info.penalty
        end
      end

      optimal_times = optimal_times.sort_by{|k,v| v}
      # logger.debug "OPTIMAL TIMES " + optimal_times.to_s
      optimal_times.each do |time_slot, penalty|
        @optimal_times.append(time_slot.strftime("%F %H:%M:%S %Z"))       
      end

    end
end
