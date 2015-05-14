class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :channel, null: false, index: true
      t.belongs_to :user, null: false, index: true
      t.string :role, null: false
      t.timestamps null: false

      t.index [:channel_id, :user_id], unique: true
    end
  end
end
