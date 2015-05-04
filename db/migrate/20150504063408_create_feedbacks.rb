class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.belongs_to :post, null: false, index: true
      t.foreign_key :posts, dependent: :delete
      t.string :status, null: false
      t.belongs_to :creator, null: false, index: true
      t.timestamps null: false

      t.index [:post_id, :creator_id], unique: true
    end
  end
end
