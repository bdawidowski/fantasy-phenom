class AddAttachmentImageToArticles < ActiveRecord::Migration
  def self.down
    remove_column :articles, :image
  end
end
