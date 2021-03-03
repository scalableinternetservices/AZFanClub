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

  # GET /polls/id/1
  def get_poll_by_poll_id
    @poll = Poll.find_by poll_id: params[:poll_id]
    redirect_to controller: 'polls', action: 'show', id: @poll.id
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
      @optimal_times = @poll.optimal_times

    end
end
