class FixSpellErrorData < ActiveRecord::Migration
  def change
      remove_column :articles, :image_date
      add_column :articles, :image_data, :text
  end
end
