class UsersController < ApplicationController
    def create
        @poll = Poll.find(params[:poll_id])
        @user = @poll.users.create(params[:user].permit(:name))
        redirect_to poll_path(@poll)
      end
end
