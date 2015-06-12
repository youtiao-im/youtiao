class Comments::Create < Mutations::Command
  required do
    integer :bulletin_id
    string :text
    string :created_by_type
    integer :created_by_id
  end

  def execute
    Comment.create!(inputs)
  end
end
