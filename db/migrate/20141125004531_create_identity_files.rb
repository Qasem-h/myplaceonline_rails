class CreateIdentityFiles < ActiveRecord::Migration
  def change
    create_table :identity_files do |t|
      t.references :identity, index: true

      t.timestamps
    end
  end
end
