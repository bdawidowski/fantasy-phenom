class User < ActiveRecord::Base
  require 'csv'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :articles
  has_many :charges
  has_many :standings
  
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      User.create! row.to_hash
    end
        users = User.all
        rocket_server = RocketChat::Server.new('https://fantasy-phenom.rocket.chat')
        rocket_session = rocket_server.login("admin", Rails.application.secrets.rocket_pw)
        users.each do |user|
            query_result = rocket_session.users.list(query: {email: user.email})
            if user.subscribed && !query_result
                    rocket_user = rocket_session.users.create(user.email.sub(/@.*?$/, ""), user.email, user.first_name + " " + user.last_name,  "fantasyphenom365",
                                         active: true, send_welcome_email: false)
                    rocket_token = rocket_session.users.create_token(user_id: rocket_user.id)
                    rocket_token = rocket_token.user_id
                    user.update(
                        was_subscribed: true,
                        rocket_token: rocket_token,
                        rocket_pw: "fantasyphenom365"
                    )
            elsif user.subscribed && query_result && user.rocket_token == nil
                rocket_token = rocket_session.users.create_token(user_id: query_result[0].id)
                rocket_token = rocket_token.user_id
                user.update(
                    was_subscribed: true,
                    rocket_token: rocket_token,
                    rocket_pw: "fantasyphenom365"
                )
            elsif query_result && !user.subscribed && user.rocket_token
                rocket_session.users.update(user.rocket_token, active: false)
            elsif query_result && user.subscribed && user.rocket_token
                rocket_session.users.update(user.rocket_token, active: true)
            end
        end
  end
  
  def subscribed?
    subscribed
  end
  
  def admin?
    admin
  end
  
  # def contributor?
  #   contributor?
  # end
  
end
