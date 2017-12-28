class AddFreeContentToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :free, :boolean, default: false
  end
end
