class CreateStamps < ActiveRecord::Migration
  def change
    create_table :stamps do |t|
      t.belongs_to :feed, null: false, index: true
      t.belongs_to :user, null: false, index: true
      t.string :kind, null: false
      t.timestamps null: false

      t.index [:feed_id, :user_id], unique: true
    end
  end
end
