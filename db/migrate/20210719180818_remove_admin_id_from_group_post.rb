class RemoveAdminIdFromGroupPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :group_posts, :admin_id, :integer
  end
end
