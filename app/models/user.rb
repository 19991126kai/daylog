# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  guest                  :boolean          default("0")
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :categories, dependent: :destroy
  has_many :logs, dependent: :destroy

  # ゲストユーザー作成＋サンプルデータ注入
  def self.create_guest_with_samples!
    guest = create!(
      email: "guest_#{Time.now.to_i}#{rand(1000)}@example.com",
      password: SecureRandom.urlsafe_base64,
      guest: true
    )
    guest.seed_guest_samples!
    guest
  end

  # サンプルデータの注入処理（内部用）
  def seed_guest_samples!
    return unless guest? # 念のためゲストユーザーの場合のみ実行

    now = Time.current

    categories_data = [
      { name: "Rails学習" },
      { name: "JavaScript基礎" },
      { name: "ポートフォリオ開発" }
    ]

    categories_data.each_with_index do |attrs, i|
      category = categories.create!(attrs)

      end1 = now - (i * 120).minutes
      start1 = end1 - 60.minutes

      end2 = end1 - 10.minutes
      start2 = end2 - 45.minutes

      self.logs.create!([
        { category: category, start_time: start1, end_time: end1, duration: ((end1 - start1) / 60).to_i },
        { category: category, start_time: start2, end_time: end2, duration: ((end2 - start2) / 60).to_i }
      ])
    end
  end
end
