# == Schema Information
#
# Table name: invoices
#
#  id         :integer          not null, primary key
#  status     :string
#  deadline   :string
#  payment    :string
#  subject    :string
#  product    :string
#  price      :string
#  quantity   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
