class CreateCurrencies < ActiveRecord::Migration[7.1]
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :acronym
      t.string :sign
      t.boolean :main

      t.timestamps
    end
  end
end
