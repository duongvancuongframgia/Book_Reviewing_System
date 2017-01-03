class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :book_title
      t.text :content
      t.integer :status, default: 1
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :requests, [:user_id, :created_at]
  end
end
