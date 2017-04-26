class AddReferenceToPost < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :comments, :posts
  end
end
