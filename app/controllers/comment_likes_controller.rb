class CommentLikesController < ApplicationController
    before_action :find_comment
    before_action :find_comment_like, only: [:destroy]

    def create
        if already_liked?
            flash[:danger] = "You can't like comment more than once."
        else
            @comment.comment_likes.create(user_id: current_user.id)
        end
        redirect_to request.referrer
    end

    def destroy
        if !(already_liked?)
            flash[:danger] = "Can not unlike."
        else
            @comment_like.destroy
        end
        redirect_to request.referrer
    end

    def find_comment_like
        @comment_like = @comment.comment_likes.find(params[:id])
    end

    private

    def already_liked?
        CommentLike.where(user_id: current_user.id, comment_id:
        params[:comment_id]).exists?
    end

    def find_comment
        @comment = Comment.find(params[:comment_id])
    end

end
