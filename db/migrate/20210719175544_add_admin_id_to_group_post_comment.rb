class AddAdminIdToGroupPostComment < ActiveRecord::Migration[5.2]
  def change
    add_column :group_post_comments, :admin_id, :integer
  end
end
