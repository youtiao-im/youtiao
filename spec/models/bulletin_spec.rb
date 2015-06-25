# == Schema Information
#
# Table name: bulletins
#
#  id             :integer          not null, primary key
#  group_id       :integer          not null
#  text           :string           not null
#  created_by_id  :integer          not null
#  checks_count   :integer          default(0), not null
#  crosses_count  :integer          default(0), not null
#  comments_count :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Bulletin, type: :model do
  it { should belong_to :group }
  it { should belong_to :created_by }
  it { should have_many :stamps }
  it { should have_many :comments }
  it { should have_one :current_stamp }
  it { should validate_length_of(:text).is_at_most(512) }
end
