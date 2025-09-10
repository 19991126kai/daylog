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

require "test_helper"

class LogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
