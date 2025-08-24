class Log < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true

  validates :date, presence: true
  validates :duration, presence: true, numericality: { greater_than: 0 }
end
