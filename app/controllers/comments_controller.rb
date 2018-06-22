class CommentsController < ApplicationController
    def create
        comment = Comment.create(comment_params)

        if comment.valid?
            comment.author = current_user.first_name
            comment.event_id = params[:id]
            comment.save
            redirect_to :back
        else
            flash[:errors] = comment.errors.full_messages
            redirect_to :back
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:content)
    end
end
