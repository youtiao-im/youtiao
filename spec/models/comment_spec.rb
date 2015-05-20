# == Schema Information
#
# Table name: comments
#
#  id            :integer          not null, primary key
#  feed_id       :integer          not null
#  text          :string           not null
#  created_by_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to :feed }
  it { should belong_to :created_by }
end
