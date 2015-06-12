class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.timestamps null: false
      t.integer :memberships_count, null: false, default: 0
    end
  end
end
