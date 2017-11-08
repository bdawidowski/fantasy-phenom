class AddDefaulttoImageData < ActiveRecord::Migration
  def change
      change_column :articles, :image_data, :text, :default => ''
  end
end
