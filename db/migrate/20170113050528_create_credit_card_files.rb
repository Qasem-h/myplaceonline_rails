class CreateCreditCardFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :credit_card_files do |t|
      t.references :credit_card, foreign_key: true
      t.references :identity_file, foreign_key: true
      t.references :identity, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
