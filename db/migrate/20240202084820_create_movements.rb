class CreateMovements < ActiveRecord::Migration[7.1]
  def change
    create_table :movements do |t|
      t.string :type
      t.string :name
      t.text :description
      t.decimal :amount
      t.references :activity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
