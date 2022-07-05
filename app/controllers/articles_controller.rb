class ArticlesController < ApplicationController
  before_action :set_article, only: %I[show edit update destroy]

  def show; end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
    @users = User.enabled
  end

  def create
    @article = Article.new(article_params)
    # we hardcode the user the article belongs to at first
    # TODO: add user to article based on session
    if @article.save
      flash[:notice] = 'Article successfully created'
      redirect_to @article
    else
      @users = User.all
      render 'new'
    end
  end

  def edit
    @users = User.enabled
  end

  def update
    if @article.update(article_params)
      flash[:notice] = 'Article successfully edited'
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    if @article.destroy
      flash[:notice] = 'Article successfully deleted'
      redirect_to articles_path
    else
      flash[:alert] = 'Article could not be deleted'
      redirect_to 'show'
    end
  end

  private

  # sets the article based on id sent in url params
  # runs before actions: show edit update destroy
  def set_article
    @article = Article.find(params[:id])
  end

  # gets article params from update and create form submitions
  def article_params
    params.require(:article).permit(:title, :body, :user_id)
  end
end
