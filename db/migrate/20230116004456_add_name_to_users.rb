class AddNameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :bio, :text
    add_column :users, :website, :string
  end
end
