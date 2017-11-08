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
        line = row.to_hash
        unless User.find_by_email(line['email'])
            User.create! line
        end
    end
  end
    
  def self.export
      h = Array.new
      User.first.attributes.each do |key, value|
          h << key
      end
      
      CSV.generate(headers: true) do |csv|
          csv << h
          all.each do |u|
              csv << u.attributes.values_at(*h)
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
