class AddMenuToMenuItems < ActiveRecord::Migration[7.2]
  def change
    add_reference :menu_items, :menu, null: false, foreign_key: true
  end
end
