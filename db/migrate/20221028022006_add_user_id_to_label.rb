class AddUserIdToLabel < ActiveRecord::Migration[6.0]
  def change
    add_reference :labels, :user, null: false, foreign_key: true
  end
end
