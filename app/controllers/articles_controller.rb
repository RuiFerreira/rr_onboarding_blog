class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    # we hardcode the user the article belongs to at first
    # TODO: add user to article based on session
    @article.user = User.first
    if @article.save
      flash[:notice] = 'Article successfully created'
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = 'Article successfully edited'
      redirect_to @article
    else
      render 'edit'
    end
  end

  private

  # gets article params from update and create form submitions
  def article_params
    params.require(:article).permit(:title, :body)
  end
end
