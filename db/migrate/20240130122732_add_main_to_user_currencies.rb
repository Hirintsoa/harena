class AddMainToUserCurrencies < ActiveRecord::Migration[7.1]
  def change
    add_column :user_currencies, :main, :boolean, default: false, null: false
  end
end
