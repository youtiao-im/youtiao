class Marks::CreateOrUpdate < Mutations::Command
  required do
    integer :bulletin_id
    string :symbol
    string :created_by_type
    integer :created_by_id
  end

  def execute
    mark = Mark.pinpoint(bulletin_id, created_by_id)
    mark.update!(symbol: symbol)
    mark.bulletin.reload
    mark
  rescue ActiveRecord::RecordNotFound
    Mark.create!(inputs)
  end
end
