class CreateBulletins < ActiveRecord::Migration
  def change
    create_table :bulletins do |t|
      t.belongs_to :group, null: false, index: true
      t.string :text, null: false
      t.belongs_to :created_by, null: false
      t.integer :checks_count, null: false, default: 0
      t.integer :crosses_count, null: false, default: 0
      t.integer :comments_count, null: false, default: 0
      t.timestamps null: false
    end
  end
end
