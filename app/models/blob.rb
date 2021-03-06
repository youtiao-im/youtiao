# == Schema Information
#
# Table name: blobs
#
#  id         :integer          not null, primary key
#  data_url   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Blob < ActiveRecord::Base
  validates :data_url, presence: true, length: { maximum: 256 }
end
