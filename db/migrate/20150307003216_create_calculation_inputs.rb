class CreateCalculationInputs < ActiveRecord::Migration
  def change
    create_table :calculation_inputs do |t|
      t.string :input_name
      t.string :input_value
      t.references :calculation_form, index: true

      t.timestamps null: true
    end
  end
end
