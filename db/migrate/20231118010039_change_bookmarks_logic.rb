class ChangeBookmarksLogic < ActiveRecord::Migration[7.0]
  def change
    remove_column :bookmarks, :attending, :boolean, default: false
    remove_column :bookmarks, :attended, :boolean, default: false

    add_column :bookmarks, :status, :string, default: "interested"
  end
end
