# == Schema Information
#
# Table name: stamps
#
#  id         :integer          not null, primary key
#  feed_id    :integer          not null
#  user_id    :integer          not null
#  kind       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Stamp, type: :model do
  it { should belong_to :feed }
  it { should belong_to :user }
end
