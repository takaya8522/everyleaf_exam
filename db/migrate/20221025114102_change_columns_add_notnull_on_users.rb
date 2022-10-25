class ChangeColumnsAddNotnullOnUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :password_digest, false
  end
end
