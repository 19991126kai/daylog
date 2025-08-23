class Category < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :name
  end

  belongs_to :user
end
