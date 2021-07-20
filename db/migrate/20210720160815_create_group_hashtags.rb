class CreateGroupHashtags < ActiveRecord::Migration[5.2]
  def change
    create_table :group_hashtags do |t|
      t.references :group, foreign_key: true
      t.references :hashtag, foreign_key: true

      t.timestamps
    end
  end
end
