# == Schema Information
#
# Table name: feeds
#
#  id              :integer          not null, primary key
#  channel_id      :integer          not null
#  text            :string           not null
#  created_by_id   :integer          not null
#  checks_count    :integer          default(0), not null
#  crosses_count   :integer          default(0), not null
#  questions_count :integer          default(0), not null
#  comments_count  :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe Feed, type: :model do
  it { should belong_to :channel }
  it { should belong_to :created_by }
  it { should have_many :attachments }
  it { should have_many :marks }
  it { should have_many :comments }
end
