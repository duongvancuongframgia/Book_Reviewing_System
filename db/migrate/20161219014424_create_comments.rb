class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :review, foreign_key: true
      t.text :content

      t.timestamps
    end
    add_index :comments, [:user_id, :review_id]
  end
end
