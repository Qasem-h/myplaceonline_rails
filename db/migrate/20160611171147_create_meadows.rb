class CreateMeadows < ActiveRecord::Migration
  def change
    create_table :meadows do |t|
      t.references :location, index: true, foreign_key: true
      t.integer :rating
      t.integer :visit_count
      t.references :identity, index: true, foreign_key: true
      t.text :notes
      t.boolean :visited

      t.timestamps null: false
    end
  end
end
