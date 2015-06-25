class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.timestamps null: false
      t.belongs_to :created_by, null: false
      t.integer :memberships_count, null: false, default: 0

      t.index :code, unique: true
    end
  end
end
