class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.belongs_to :bulletin, null: false
      t.string :symbol, null: false
      t.belongs_to :created_by, polymorphic: true, null: false
      t.timestamps null: false

      t.index [:bulletin_id, :created_by_id], unique: true
    end
  end
end
