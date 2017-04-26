class AddPostIdToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :postId, :integer, null: false, default: 0
  end
end
