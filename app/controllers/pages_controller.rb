class PagesController < ApplicationController
  def home
  end

  def about
  end

  def services
  end

  def news
    @articles = Article.all
  end
end
