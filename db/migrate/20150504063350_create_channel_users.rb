class CreateChannelUsers < ActiveRecord::Migration
  def change
    create_table :channel_users do |t|
      t.belongs_to :channel, null: false, index: true
      t.foreign_key :channels, dependent: :delete
      t.belongs_to :user, null: false, index: true
      t.foreign_key :users, dependent: :delete
      t.string :role, null: false
      t.timestamps null: false

      t.index [:channel_id, :user_id], unique: true
    end
  end
end
