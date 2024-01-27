class CreateConfigExceptions < ActiveRecord::Migration[7.1]
  def change
    create_table :config_exceptions do |t|
      t.string :value
      t.references :configuration, null: false, foreign_key: true

      t.timestamps
    end
  end
end
