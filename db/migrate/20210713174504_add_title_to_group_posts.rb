class AddTitleToGroupPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :group_posts, :title, :string
  end
end
