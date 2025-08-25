class AddStartAndEndTimeToLogs < ActiveRecord::Migration[8.0]
  def change
    add_column :logs, :start_time, :datetime
    add_column :logs, :end_time, :datetime
  end
end
