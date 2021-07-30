class ArticlesController < ApplicationController
    before_action :logged_in_user, only: [:edit, :create, :destroy, :destroy_all]
    before_action :correct_user, only: [:edit, :update, :destroy, :destroy_all]
    
    def index
        @articles = Article.all
    end


    def show 
        @article = Article.find(params[:id])
    end


    def new
        @article = Article.new
    end


    def create
        @article = current_user.articles.build(article_params) if logged_in?
        puts "ARTICLE PARAMS <<<<<<< #{article_params} >>>>>>>>>"
        
        if @article.save
            flash[:success] = "Article `#{@article.title}` created successfully."
            redirect_to @article
        else
            render :new
        end
    end

    def edit
        @article = current_user.articles.find_by(id: params[:id])
        if !@article.nil?
            render :edit
        else 
            flash[:danger] = "Not authorized to edit article."
            redirect_to root_path
        end
    end


    def update
        @article = current_user.articles.find(params[:id])

        if @article.update(article_params)
            flash[:success] = "Article `#{@article.title}` updated."
            redirect_to @article
        else
            render :edit
        end
    end


    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        flash[:success] = "Article '#{@article.title}' deleted"
        redirect_to root_path
    end

    # Delete all of users articles
    def destroy_all
        @articles = Article.where(user_id: current_user).all
        #@articles = current_user.articles.where(:id => params[:id])
        count_articles = @articles.count

        if @articles.exists?
            @articles.destroy_all
            flash[:success] = "You have deleted all your articles. 
                                Total of #{count_articles} articles deleted."
            redirect_to root_path
        else
            flash[:success] = "You have no articles for deletion."
            redirect_to edit_user_url(current_user)
        end

    end


  private 

    def article_params
        params.require(:article).permit(:title, :body, :user_id)
    end

    # To confirm that it's the correct user
    def correct_user
        #@article = current_user.articles.find_by(id: params[:id])
        @article = current_user.articles.where(:user_id => params[:id])
        if @article.nil? 
            redirect_to(root_url)
            flash[:danger] = "Unauthorized action on article."
        end
    end

end
