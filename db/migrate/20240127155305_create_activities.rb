class CreateActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.datetime :start_date
      t.float :balance

      t.timestamps
    end
  end
end
