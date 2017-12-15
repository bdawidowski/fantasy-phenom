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
    @articles = Article.where(:approved => true).order(created_at: :desc).limit(30)
    @article_newest = @articles.first
    @articles_even, @articles_odd, @articles_all = []
    @articles.each_with_index do |article, i|
      if i != 0 and i % 2 == 0 and i <= 8
        @articles_even.push(article)
      elsif i != 0 and i <= 8
        @articles_odd.push(article)
      else
        @articles_all.push(article)
      end
    end
  end
end
