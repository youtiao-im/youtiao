class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.belongs_to :channel, null: false, index: true
      t.string :text, null: false
      t.belongs_to :created_by, null: false, index: true
      t.integer :checks_count, null: false, default: 0
      t.integer :crosses_count, null: false, default: 0
      t.integer :questions_count, null: false, default: 0
      t.integer :comments_count, null: false, default: 0
      t.integer :stars_count, null: false, default: 0
      t.timestamps null: false
    end
  end
end
