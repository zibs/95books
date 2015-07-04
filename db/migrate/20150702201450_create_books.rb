class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :author
      t.string :title
      t.string :publisher

      t.timestamps null: false
    end
    add_index :books, :reader_id
  end
end
