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
    @articles = Article.where(:approved => true).order(created_at: :desc).limit(46)
    @article_newest = @articles[0]
    @articles_even =[]
    @articles_odd = []
    @articles_all = []
    @articles.each_with_index do |article, i|
      if i != 0 and i % 2 == 0 and i <= 12
        @articles_even << article
      elsif i != 0 and i <= 12
        @articles_odd << article
      else
        @articles_all << article
      end
    end
  end
end
