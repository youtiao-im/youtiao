class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :name, null: false
      t.belongs_to :created_by, null: false, index: true
      t.timestamps null: false
    end
  end
end
