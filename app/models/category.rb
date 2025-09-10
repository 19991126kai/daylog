# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :name
  end

  belongs_to :user
  has_many :logs
end
