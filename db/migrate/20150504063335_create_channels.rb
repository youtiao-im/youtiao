class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.belongs_to :creator, null: false, index: true
      t.string :name, null: false
      t.timestamps null: false
    end
  end
end
