# == Schema Information
#
# Table name: feeds
#
#  id         :integer          not null, primary key
#  channel_id :integer          not null
#  creator_id :integer          not null
#  text       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Feed, type: :model do
  it { should belong_to :channel }
  it { should belong_to :creator }
  it { should have_many :attachments }
  it { should have_many :stamps }
end
