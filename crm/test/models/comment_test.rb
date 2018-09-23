# == Schema Information
#
# Table name: comments
#
#  id                          :integer          not null, primary key
#  body                        :string
#  picture                     :string
#  limited_progress            :string
#  limited_start               :string
#  limited_each_name           :string
#  limited_each_start          :string
#  limited_each_curriculum     :string
#  limited_offjt_time          :string
#  limited_ojt_time            :string
#  limited_supply              :string
#  limited_comment             :string
#  carriaup_progress           :string
#  carriaup_start              :string
#  carriaup_each_name          :string
#  carriaup_each_limited_start :string
#  carriaup_each_regular       :string
#  carriaup_each_supply        :string
#  carriaup_comment            :string
#  system_progress             :string
#  system_start                :string
#  system_subsidyname          :string
#  system_each_name            :string
#  system_implementation       :string
#  system_supply               :string
#  system_comment              :string
#  company_id                  :integer
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  status_cd                   :integer          default(0)
#

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
