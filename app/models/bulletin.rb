# == Schema Information
#
# Table name: bulletins
#
#  id              :integer          not null, primary key
#  group_id        :integer          not null
#  text            :string           not null
#  created_by_id   :integer          not null
#  created_by_type :string           not null
#  checks_count    :integer          default(0), not null
#  crosses_count   :integer          default(0), not null
#  comments_count  :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Bulletin < ActiveRecord::Base
  belongs_to :group
  belongs_to :created_by, polymorphic: true
  has_many :stamps
  has_many :comments
  has_one :current_stamp, -> { where(created_by: User.current.memberships) },
          class_name: 'Stamp'

  scope :before_id, -> (id) { where('bulletins.id<?', id) }
end
