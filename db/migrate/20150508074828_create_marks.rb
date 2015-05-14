class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.belongs_to :feed, null: false, index: true
      t.belongs_to :user, null: false, index: true
      t.string :symbol, null: false
      t.timestamps null: false

      t.index [:feed_id, :user_id], unique: true
    end
  end
end
