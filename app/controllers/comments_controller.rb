class CommentsController < ApplicationController
    def create
        @poll = Poll.find(params[:poll_id])
        @user = User.find(params[:user_id])
        @comment = @user.comments.create({body: comment_params[:body], user_id: @user.id})
        #redirect_to poll_user_path(@poll, @user)
        respond_to do |format|
            if @comment.save
              format.html { redirect_to poll_user_path(@poll, @user) , notice: "Comment successfully posted." }
              format.json { render :show, status: :created, location: @user }
            else
              format.html { redirect_to poll_user_path(@poll, @user), alert: @comment.errors.full_messages }
              format.json { render json: @comment.errors }
            end
          end
    end

    def comment_params
        params.require(:comment).permit(:body)
    end
end