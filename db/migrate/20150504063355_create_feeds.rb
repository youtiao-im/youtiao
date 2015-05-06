class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.belongs_to :channel, null: false, index: true
      t.foreign_key :channels, dependent: :delete
      t.string :content, null: false
      t.belongs_to :creator, null: false, index: true
      t.timestamps null: false
    end
  end
end
