class CreateArticles < ActiveRecord::Migration
  def change
    drop_table :articles
    create_table :articles do |t|
      t.string :title
      t.text :content

      t.timestamps null: false
    end
  end
end
