class PagesController < ApplicationController
  def home
    redirect_to articles_path if logged_in?
    @articles = Article.live.paginate(page: params[:page], per_page: 5)
  end
end
