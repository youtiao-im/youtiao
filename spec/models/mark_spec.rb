# == Schema Information
#
# Table name: marks
#
#  id              :integer          not null, primary key
#  bulletin_id     :integer          not null
#  symbol          :string           not null
#  created_by_id   :integer          not null
#  created_by_type :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe Mark, type: :model do
  it { should belong_to :bulletin }
  it { should belong_to :created_by }
end
