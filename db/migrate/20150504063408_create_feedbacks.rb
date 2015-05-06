class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.belongs_to :feed, null: false, index: true
      t.foreign_key :feeds, dependent: :delete
      t.string :sticker, null: false
      t.belongs_to :creator, null: false, index: true
      t.timestamps null: false

      t.index [:feed_id, :creator_id], unique: true
    end
  end
end
