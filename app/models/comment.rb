# == Schema Information
#
# Table name: comments
#
#  id              :integer          not null, primary key
#  bulletin_id     :integer          not null
#  text            :string           not null
#  created_by_id   :integer          not null
#  created_by_type :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Comment < ActiveRecord::Base
  belongs_to :bulletin
  belongs_to :created_by, polymorphic: true

  scope :after_id, -> (id) { where('comments.id>?', id) }

  counter_culture :bulletin
end
