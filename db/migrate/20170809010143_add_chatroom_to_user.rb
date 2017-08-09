class AddChatroomToUser < ActiveRecord::Migration
  def change
    add_column :users, :chatroom, :boolean
  end
end
