class CreateBlobs < ActiveRecord::Migration
  def change
    create_table :blobs do |t|
      t.string :data_url, null: false
      t.timestamps null: false
    end
  end
end
