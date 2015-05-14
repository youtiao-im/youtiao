# == Schema Information
#
# Table name: channels
#
#  id            :integer          not null, primary key
#  created_by_id :integer          not null
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Channel, type: :model do
  it { should belong_to :created_by }
  it { should have_many :memberships }
  it { should have_many :feeds }
end
