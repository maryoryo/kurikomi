class AddImpressionsCountToGroupPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :group_posts, :impressions_count, :integer, default: 0
  end
end
