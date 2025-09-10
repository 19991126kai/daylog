# == Schema Information
#
# Table name: logs
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  category_id :integer
#  duration    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  start_time  :datetime
#  end_time    :datetime
#

class Log < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :duration, presence: true, numericality: { greater_than: 0 }

  # 一覧表示用の日付の仮想属性
  def start_date
    start_time&.to_date
  end
end
