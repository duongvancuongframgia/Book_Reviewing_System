class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.date :publish_date
      t.string :author
      t.string :image
      t.integer :page
      t.float :rating, default: 0.0
      t.references :category

      t.timestamps
    end
    add_foreign_key :books, :categories
    add_index :books, [:category_id, :created_at]
  end
end
