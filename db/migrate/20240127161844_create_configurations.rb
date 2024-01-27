class CreateConfigurations < ActiveRecord::Migration[7.1]
  def change
    create_table :configurations do |t|
      t.string :type
      t.string :name
      t.string :base
      t.integer :range_amount
      t.decimal :amount
      t.boolean :automatic
      t.string :preferred_day

      t.timestamps
    end
  end
end
