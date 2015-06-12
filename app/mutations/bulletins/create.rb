class Bulletins::Create < Mutations::Command
  required do
    integer :group_id
    string :text
    string :created_by_type
    integer :created_by_id
  end

  def execute
    Bulletin.create!(inputs)
  end
end
