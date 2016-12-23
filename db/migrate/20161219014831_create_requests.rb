class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.references :user, foreign_key: true
      t.string :book_title
      t.boolean :status

      t.timestamps
    end
    add_foreign_key :requests, :users
    add_index :requests, [:user_id, :created_at]
  end
end
