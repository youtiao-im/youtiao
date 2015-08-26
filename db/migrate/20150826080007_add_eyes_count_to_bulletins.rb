class AddEyesCountToBulletins < ActiveRecord::Migration
  def change
    add_column :bulletins, :eyes_count, :integer, null: false, default: 0
  end
end
