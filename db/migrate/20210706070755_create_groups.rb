class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :group_image
      t.text :introduction
      t.integer :genre_id

      t.timestamps
    end
  end
end
