class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :feed, null: false, index: true
      t.string :text, null: false
      t.belongs_to :created_by, null: false, index: true
      t.timestamps null: false
    end
  end
end
