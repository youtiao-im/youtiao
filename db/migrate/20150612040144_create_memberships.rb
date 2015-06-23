class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :group, null: false
      t.belongs_to :user, null: false, index: true
      t.string :role, null: false
      t.timestamps null: false

      t.index [:group_id, :user_id], unique: true
    end
  end
end
