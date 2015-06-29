# == Schema Information
#
# Table name: groups
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  code              :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  created_by_id     :integer          not null
#  memberships_count :integer          default(0), not null
#

class Group < ActiveRecord::Base
  belongs_to :created_by, class_name: 'User'
  has_many :memberships
  has_many :bulletins
  has_one :current_membership, -> { where(user_id: User.current.id) },
          class_name: 'Membership'

  validates :name,
            presence: true,
            length: { minimum: 2, maximum: 32 },
            format: /\A[^@#][[:print:]]+\z/

  validates :code,
            presence: true,
            uniqueness: true,
            length: { minimum: 2, maximum: 40 },
            format: /\A[\w\-]+\z/

  before_validation :generate_code, on: :create

  def generate_code
    return if name.nil? || !code.nil?
    name_slug = name.to_url
    loop do
      self.code = "#{name_slug}-#{SecureRandom.random_number(9000) + 1000}"
      break unless Group.exists?(code: code)
    end
  end
end
