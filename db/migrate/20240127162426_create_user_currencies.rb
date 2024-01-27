class CreateUserCurrencies < ActiveRecord::Migration[7.1]
  def change
    create_table :user_currencies do |t|
      t.references :currency, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
