class CreateActivityParticipants < ActiveRecord::Migration[7.1]
  def change
    create_table :activity_participants do |t|
      t.references :activity, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
