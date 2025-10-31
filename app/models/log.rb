# == Schema Information
#
# Table name: logs
#
#  id          :integer          not null, primary key
#  category_id :integer
#  duration    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  study_date  :date             not null
#

class Log < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true

  validates :study_date, presence: true
  validates :duration, presence: true, numericality: { greater_than: 0 }
end
