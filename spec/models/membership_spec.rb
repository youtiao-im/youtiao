# == Schema Information
#
# Table name: memberships
#
#  id         :integer          not null, primary key
#  group_id   :integer          not null
#  user_id    :integer          not null
#  role       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Membership, type: :model do
  it { should belong_to :group }
  it { should belong_to :user }
  it { should validate_presence_of :role }
end
