class RenameTypeToCategoryInConfigurations < ActiveRecord::Migration[7.1]
  def change
    rename_column :configurations, :type, :category
  end
end
