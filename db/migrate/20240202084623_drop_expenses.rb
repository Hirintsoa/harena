class DropExpenses < ActiveRecord::Migration[7.1]
  def change
    drop_table :expenses
  end
end
