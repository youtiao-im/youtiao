# == Schema Information
#
# Table name: groups
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  code              :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  created_by_id     :integer          not null
#  memberships_count :integer          default(0), not null
#

require 'rails_helper'

RSpec.describe Group, type: :model do
  it { should belong_to :created_by }
  it { should have_many :memberships }
  it { should have_many :bulletins }
  it { should have_one :current_membership }
  it { should validate_presence_of :name }
  it { should validate_length_of(:name).is_at_least(2).is_at_most(32) }
  it { should validate_presence_of :code }
  it { should validate_uniqueness_of :code }
  it { should validate_length_of(:code).is_at_least(2).is_at_most(40) }
end
