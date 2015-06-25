# == Schema Information
#
# Table name: blobs
#
#  id         :integer          not null, primary key
#  data_url   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Blob, type: :model do
  it { should validate_length_of(:data_url).is_at_most(256) }
end
