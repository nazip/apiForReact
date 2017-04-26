class AddRefToComments < ActiveRecord::Migration[5.0]
  def change
    add_reference :comments, :post, index: true
  end
end
