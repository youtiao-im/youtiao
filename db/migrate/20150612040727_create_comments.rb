class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :bulletin, null: false, index: true
      t.string :text, null: false
      t.belongs_to :created_by, null: false
      t.timestamps null: false
    end
  end
end
