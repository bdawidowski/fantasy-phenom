class Article < ActiveRecord::Base
    extend FriendlyId
    include ImageUploader[:image]
    friendly_id :title, use: :slugged
    belongs_to :user
    
    
    def previous
      Article.where(["id < ?", id]).last
    end
    
    def following
      Article.where(["id > ?", id]).first
    end
end
