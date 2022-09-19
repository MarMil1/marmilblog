class CommentsController < ApplicationController
    before_action :logged_in_user, only: [:edit, :create, :destroy, :destroy_all]
    before_action :correct_user, only: [:edit, :update, :destroy, :destroy_all]

    def index
        @comments = Comment.all
    end

    def show
        @comment = Comment.find(params[:id])
    end
    
    def new
        @comment = Comment.new(comment_params)
    end

    
    def create
        @article = Article.find(params[:article_id])
        @comment = current_user.comments.build(comment_params)
        # Assign article_id and insert it to comments table
        @comment.article_id = @article.id
        
        if @comment.save
            flash[:success] = "Comment posted successfully."
            redirect_to article_path(@article)
        else
            flash[:danger] = "Something went wrong."
            redirect_to article_path(@article)
        end
    end


    def edit
        @article = Article.find(params[:article_id])
        @comment = current_user.comments.find_by(id: params[:id])

        if !@comment.nil?
            render :edit
        else 
            flash[:danger] = "Not authorized to edit article."
            redirect_to @article
        end
    end


    def update
        @article = Article.find(params[:article_id])
        @comment = current_user.comments.find(params[:id])

        if @comment.update(comment_params)
            flash[:success] = "Comment updated successfully."
            redirect_to @article
        else
            render :edit
        end
    end


    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        flash[:success] = "Comment successfully deleted."
        redirect_to request.referrer || root_url
    end


    def destroy_all
        @comments = Comment.where(user_id: current_user).all
        count_comments = @comments.count

        if @comments.exists?
            @comments.destroy_all
            flash[:success] = "You have deleted all your comments. 
                                Total of #{count_comments} comments deleted."
            redirect_to edit_user_url(current_user)
        else
            flash[:success] = "You have no comments for deletion."
            redirect_to edit_user_url(current_user)
        end
    end


  private
    
    def comment_params  
        params.require(:comment).permit(:body, :user_id, :parent_id)
    end


    #To confirm that it's the correct user
    def correct_user
        @comment = current_user.comments.where(:user_id => params[:id])
        if @comment.nil? 
            redirect_to(root_url)
            flash[:danger] = "Unauthorized action on article."
        end
    end


end
