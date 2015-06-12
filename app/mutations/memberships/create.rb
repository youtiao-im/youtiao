class Memberships::Create < Mutations::Command
  required do
    integer :group_id
    integer :user_id
    string :role
  end

  def execute
    Membership.create!(inputs)
  end
end
