# == Schema Information
#
# Table name: memberships
#
#  id         :integer          not null, primary key
#  channel_id :integer          not null
#  user_id    :integer          not null
#  role       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Membership, type: :model do
  it { should belong_to :channel }
  it { should belong_to :user }
end