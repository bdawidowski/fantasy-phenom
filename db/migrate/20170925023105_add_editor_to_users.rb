class AddEditorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :editor, :boolean, default: false
    add_column :articles, :approved, :boolean, default: false
  end
end
