class RemoveMainFromCurrencies < ActiveRecord::Migration[7.1]
  def change
    remove_column :currencies, :main, :boolean
  end
end
