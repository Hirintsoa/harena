class RemoveLogDataFromActivities < ActiveRecord::Migration[7.1]
  def change
    remove_column :activities, :log_data, :jsonb
  end
end
