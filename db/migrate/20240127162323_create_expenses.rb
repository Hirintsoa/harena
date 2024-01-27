class CreateExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :expenses do |t|
      t.string :name
      t.text :description
      t.decimal :amount
      t.references :activity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
