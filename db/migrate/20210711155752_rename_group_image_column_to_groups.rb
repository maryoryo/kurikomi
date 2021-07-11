class RenameGroupImageColumnToGroups < ActiveRecord::Migration[5.2]
  
  def change
    rename_column :groups, :group_image, :group_image_id
  end
end
