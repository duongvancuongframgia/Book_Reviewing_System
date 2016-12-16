class CreateBookmarks < ActiveRecord::Migration[5.0]
  def change
    create_table :bookmarks do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.boolean :status_bookmark
      t.boolean :favorite

      t.timestamps
    end
  end
end
