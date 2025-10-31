class ChangeLogsAddStudyDate < ActiveRecord::Migration[8.0]
  def up
    add_column :logs, :study_date, :date

    # 既存データを start_time から変換して埋める
    execute <<~SQL
      UPDATE logs
      SET study_date = DATE(start_time)
      WHERE start_time IS NOT NULL
    SQL

    # start_time と end_time を削除
    remove_column :logs, :start_time, :datetime
    remove_column :logs, :end_time, :datetime

    # null 制約を追加
    change_column_null :logs, :study_date, false
  end

  def down
    add_column :logs, :start_time, :datetime
    add_column :logs, :end_time, :datetime
    remove_column :logs, :study_date, :date
  end
end
