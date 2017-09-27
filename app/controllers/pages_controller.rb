class PagesController < ApplicationController
  def home
    # if signed_in?
    #   if !session[:rocket] && current_user_subscribed? 
    #     rocket_server = RocketChat::Server.new('https://fantasyphenom.rocket.chat/')
    #     rocket_session = rocket_server.login(current_user.email.sub(/@.*?$/, ""), current_user.rocket_pw)
    #     session[:rocket] = true 
    #   end
    # end
    # session[:rocket] = false
    
  end

  def about
  end

  def services
  end

  def news
    @articles = Article.where(:approved => true).order(created_at: :desc).limit(11)
  end
end
