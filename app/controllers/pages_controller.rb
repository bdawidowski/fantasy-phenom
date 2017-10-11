class PagesController < ApplicationController
  def home
    @contact = Contact.new
  end

  def about
  end

  def services
  end
    
  def comingsoon
  end

  def news
    @articles = Article.where(:approved => true).order(created_at: :desc).limit(11)
  end
end
