class RemoveDateFromLogs < ActiveRecord::Migration[8.0]
  def up
    remove_column :logs, :date
  end

  def down
    add_column :logs, :date, :date
  end
end
