class ArticlesController < ApplicationController
  before_action :set_article, only: %I[show edit update destroy]
  before_action :enabled_users, only: %I[new edit]

  def show; end

  def index
    # main article listing page will only list Live and Draft articles or only Live articles based on
    # all = true param
    @articles = if params[:all]
                  Article.user_live_articles
                else
                  Article.live
                end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    # TODO: add user to article based on session
    if @article.save
      flash[:notice] = 'Article successfully created'
      redirect_to @article
    else
      @users = enabled_users # not in before action so it only triggers when needed
      render 'new'
    end
  end

  def edit; end

  def update
    # not saved if fail so we can always increment
    @article.edition_counter += 1
    if @article.update(article_params)
      flash[:notice] = 'Article successfully edited'
      redirect_to @article
    else
      @users = enabled_users
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

  def enabled_users
    @users = User.enabled
  end
end
