class CreateWishes < ActiveRecord::Migration[7.1]
  def change
    create_table :wishes do |t|
      t.string :name
      t.text :description
      t.integer :estimation
      t.decimal :priority
      t.references :activity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
