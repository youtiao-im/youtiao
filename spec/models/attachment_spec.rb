# == Schema Information
#
# Table name: attachments
#
#  id         :integer          not null, primary key
#  feed_id    :integer          not null
#  text       :string           not null
#  url        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Attachment, type: :model do
  it { should belong_to :feed }
end
