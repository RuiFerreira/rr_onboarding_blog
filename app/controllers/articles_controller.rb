class ArticlesController < ApplicationController
  before_action :set_article, only: %I[show edit update destroy submit_draft approve]
  before_action :enabled_users, only: %I[new edit]
  before_action :validate_session, except: %I[show]

  def show; end

  def index
    @articles = Article.user_live_articles(current_user)
  end

  def pending
    @articles = Article.articles_user_can_review(current_user)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
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
    if @article.update(article_params) && !@article.live?
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

  def submit_draft
    if @article.draft? && @article.update(status: :pending)
      flash[:notice] = 'Article successfully submitted. Please await its review'
    else
      flash[:alert] = 'Article could not be submitted'
    end
    redirect_to @article
  end

  def approve
    if @article.pending? && @article.update(status: :live)
      flash[:notice] = 'Article successfully reviewed.'
    else
      flash[:alert] = 'Article could not be reviewed'
    end
    redirect_to @article
  end

  private

  # sets the article based on id sent in url params
  # runs before actions: show edit update destroy
  def set_article
    @article = Article.find(params[:id])
  end

  # gets article params from update and create form submitions
  def article_params
    params.require(:article).permit(:title, :body, tag_ids: [])
  end

  def enabled_users
    @users = User.enabled
  end
end
