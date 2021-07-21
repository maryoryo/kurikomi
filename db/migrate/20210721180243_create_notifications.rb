class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :group_post_id
      t.integer :group_post_comment_id
      t.integer :room_id
      t.integer :chat_id
      t.string :action
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
    
    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :group_post_id
    add_index :notifications, :group_post_comment_id
    add_index :notifications, :room_id
    add_index :notifications, :chat_id
  end
end
