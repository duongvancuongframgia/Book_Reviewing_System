class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.references :activity, foreign_key: true
      t.boolean :status_like

      t.timestamps
    end
  end
end
