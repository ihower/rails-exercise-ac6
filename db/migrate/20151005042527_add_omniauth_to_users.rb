class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_uid, :string
    add_index :users, :fb_uid

    add_column :users, :fb_token, :string
  end
end
