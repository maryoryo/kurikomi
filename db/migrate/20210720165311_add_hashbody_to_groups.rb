class AddHashbodyToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :hashbody, :text
  end
end
