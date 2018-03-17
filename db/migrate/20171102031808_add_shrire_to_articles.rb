class AddShrireToArticles < ActiveRecord::Migration
  def change
      add_column :articles, :image_date, :text
  end
end
