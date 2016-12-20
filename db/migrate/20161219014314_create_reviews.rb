class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.string :title
      t.text :content

      t.timestamps
    end
    add_index :reviews, [:user_id, :book_id]
  end
end
