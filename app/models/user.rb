class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :categories, dependent: :destroy
  has_many :logs, dependent: :destroy

  def self.guest
    create!(
      email: "guest_#{SecureRandom.hex(10)}@example.com",
      password: SecureRandom.urlsafe_base64,
      name: "guest",
      guest: true
    )
  end
end
