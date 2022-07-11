class PagesController < ApplicationController
  def home
    @articles = Article.live.paginate(page: params[:page], per_page: 5)
  end
end
