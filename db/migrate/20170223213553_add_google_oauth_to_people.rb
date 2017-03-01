class AddGoogleOauthToPeople < ActiveRecord::Migration[5.0]
  def change
    add_column :people, :oauth_token, :string
    add_column :people, :oauth_expires_at, :datetime
    add_column :people, :uid, :string
    add_column :people, :provider, :string
  end
end
