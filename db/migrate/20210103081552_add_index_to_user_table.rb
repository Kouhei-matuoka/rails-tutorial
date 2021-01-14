class AddIndexToUserTable < ActiveRecord::Migration[5.0]
  def change
    add_index :social_profiles, :provider, unique: true
    add_index :social_profiles, :uid, unique: true
  end
end
