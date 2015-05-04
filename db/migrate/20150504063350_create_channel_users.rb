class CreateChannelUsers < ActiveRecord::Migration
  def change
    create_table :channel_users do |t|

      t.timestamps null: false
    end
  end
end
