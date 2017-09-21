class PagesController < ApplicationController
  def home
  end

  def about
  end

  def services
  end

  def news
    @articles = Article.all.order(created_at: :desc).limit(11)
  end
end
