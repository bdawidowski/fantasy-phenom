class Article < ActiveRecord::Base
    extend FriendlyId
    friendly_id :title, use: :slugged
    has_one :user
    
    has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
