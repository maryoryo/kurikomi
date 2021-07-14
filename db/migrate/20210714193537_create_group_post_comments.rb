class CreateGroupPostComments < ActiveRecord::Migration[5.2]
  def change
    create_table :group_post_comments do |t|
      t.references :user, foreign_key: true
      t.references :group_post, foreign_key: true
      t.string :comment

      t.timestamps
    end
  end
end
