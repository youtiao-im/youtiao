# == Schema Information
#
# Table name: groups
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  memberships_count :integer          default(0), not null
#

require 'rails_helper'

RSpec.describe Group, type: :model do
  it { should have_many :memberships }
  it { should have_many :bulletins }
  it { should have_one :current_membership }
end
