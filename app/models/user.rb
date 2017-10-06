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
