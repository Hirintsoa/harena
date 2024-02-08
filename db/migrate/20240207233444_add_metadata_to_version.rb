class AddMetadataToVersion < ActiveRecord::Migration[7.1]
  def change
    add_column :versions, :comment, :text
    add_column :versions, :ip, :string
    add_column :versions, :user_agent, :string
  end
end
