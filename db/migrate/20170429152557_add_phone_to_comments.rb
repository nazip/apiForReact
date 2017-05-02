class AddPhoneToComments < ActiveRecord::Migration[5.0]
  def change
  	add_column :comments, :phone, :string, null: false, default: ''
  end
end
