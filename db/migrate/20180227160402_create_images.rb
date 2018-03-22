class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.references :document, foreign_key: true
      t.string :upload

      t.timestamps
    end
  end
end
