class AddAdminIdToGroupPost < ActiveRecord::Migration[5.2]
  def change
    add_column :group_posts, :admin_id, :integer
  end
end
