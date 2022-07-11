class PagesController < ApplicationController
  def home
    @articles = Article.live
  end
end
