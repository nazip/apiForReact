class AddImageToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :image_src, :string
    add_column :posts, :image_alt, :string
    add_column :posts, :image_width, :integer
    add_column :posts, :image_height, :integer
    add_column :posts, :metadata_author, :string
    add_column :posts, :metadata_updated_at, :date
    add_column :posts, :metadata_created_at, :date
    add_column :posts, :metadata_like, :integer
  end
end
