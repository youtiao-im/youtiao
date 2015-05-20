class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name, null: false
      t.belongs_to :created_by, null: false, index: true
      t.integer :memberships_count, null: false, default: 0
      t.timestamps null: false
    end
  end
end
