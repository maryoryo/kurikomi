class RemoveAdminIdFromGroupPostComment < ActiveRecord::Migration[5.2]
  def change
    remove_column :group_post_comments, :admin_id, :integer
  end
end
