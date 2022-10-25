class CreateLabelsUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :labels_users do |t|
      t.references :label, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
    end
  end
end
