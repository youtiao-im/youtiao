class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.belongs_to :feed, null: false, index: true
      t.belongs_to :user, null: false, index: true
      t.timestamps null: false

      t.index [:feed_id, :user_id], unique: true
    end
  end
end
