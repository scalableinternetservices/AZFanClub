require "test_helper"

class PollsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @poll = polls(:poll)
  end

  test "should get index" do
    get polls_url
    assert_response :success
  end

  test "should get new" do
    get new_poll_url
    assert_response :success
  end

  test "should create poll" do
    assert_difference('Poll.count') do
      post polls_url, params: { poll: { title: @poll.title, timeframe_start: @poll.timeframe_start, timeframe_end: @poll.timeframe_end } }
    end

    assert_redirected_to poll_url(Poll.order("created_at ASC").last)
  end

  test "should show poll" do
    get poll_url(@poll)
    assert_response :success
  end

  test "should get edit" do
    get edit_poll_url(@poll)
    assert_response :success
  end

  test "should update poll" do
    patch poll_url(@poll), params: { poll: { title: @poll.title, timeframe_start: @poll.timeframe_start, timeframe_end: @poll.timeframe_end } }
    assert_redirected_to poll_url(@poll)
  end

  test "should destroy poll" do
    assert_difference('Poll.count', -1) do
      delete poll_url(@poll)
    end

    assert_redirected_to polls_url
  end

  test "should fail on blank start time" do
    post polls_url, params: { poll: { title: @poll.title, timeframe_start: nil, timeframe_end: @poll.timeframe_end } }
    assert_equal 422, status
  end

  test "should fail on blank end time" do
    post polls_url, params: { poll: { title: @poll.title, timeframe_start: @poll.timeframe_start, timeframe_end: nil } }
    assert_equal 422, status
  end


  test "should fail on invalid start time" do
    post polls_url, params: { poll: { title: @poll.title, timeframe_start: "invalid start", timeframe_end: @poll.timeframe_end } }
    assert_equal 422, status
  end


  test "should fail on invalid end time" do
    post polls_url, params: { poll: { title: @poll.title, timeframe_start: @poll.timeframe_start, timeframe_end: "invalid end" } }
    assert_equal 422, status
  end


  test "should fail on start time after end time" do
    post polls_url, params: { poll: { title: @poll.title, timeframe_start: @poll.timeframe_end, timeframe_end: @poll.timeframe_start } }
    assert_equal 422, status
  end
end
