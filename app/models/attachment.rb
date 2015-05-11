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

class Attachment < ActiveRecord::Base
  belongs_to :feed

  validates :text, presence: true
  validates :url, presence: true
end
