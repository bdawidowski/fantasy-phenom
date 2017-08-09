class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :articles
  has_many :charges
  has_many :standings
  def subscribed?
    stripe_subscription_id?
  end
  
  def admin?
    admin
  end
  
  # def contributor?
  #   contributor?
  # end
  
end
