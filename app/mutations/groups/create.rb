class Groups::Create < Mutations::Command
  required do
    string :name
  end

  def execute
    group = Group.create!(inputs)
    Membership.create!(group: group, user: User.current, role: :owner)
    group
  end
end
