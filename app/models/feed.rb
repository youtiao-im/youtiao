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
#  stars_count     :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Feed < ActiveRecord::Base
  belongs_to :channel
  belongs_to :created_by, class_name: 'User'
  has_many :attachments
  has_many :comments
  has_many :marks
  has_one :mark, -> { where(user_id: User.current.id) }

  validates :text, presence: true
end
