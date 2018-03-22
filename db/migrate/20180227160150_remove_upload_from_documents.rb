class RemoveUploadFromDocuments < ActiveRecord::Migration[5.1]
  def change
    remove_column :documents, :upload
  end
end
