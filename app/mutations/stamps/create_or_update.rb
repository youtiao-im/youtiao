class Stamps::CreateOrUpdate < Mutations::Command
  required do
    integer :bulletin_id
    string :symbol
    string :created_by_type
    integer :created_by_id
  end

  def execute
    # TODO: recreate
    stamp = Stamp.pinpoint(bulletin_id, created_by_id)
    stamp.update!(symbol: symbol)
    stamp.bulletin.reload
    stamp
  rescue ActiveRecord::RecordNotFound
    Stamp.create!(inputs)
  end
end
