class DropIncomes < ActiveRecord::Migration[7.1]
  def change
    drop_table :incomes
  end
end
