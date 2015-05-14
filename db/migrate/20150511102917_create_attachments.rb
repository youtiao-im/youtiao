class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.belongs_to :feed, null: false, index: true
      # t.string :description, null: false
      # t.string :url, null: false
      t.timestamps null: false
    end
  end
end
