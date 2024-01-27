class CreateAutomations < ActiveRecord::Migration[7.1]
  def change
    create_table :automations do |t|
      t.string :operator_class
      t.references :configuration, null: false, foreign_key: true
      t.references :activity, null: false, foreign_key: true
      t.datetime :next_execution

      t.timestamps
    end
  end
end
