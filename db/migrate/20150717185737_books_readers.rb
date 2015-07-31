class BooksReaders < ActiveRecord::Migration
  def change
  	 create_table :books_readers, :id => false do |t|
      t.integer :book_id
      t.integer :reader_id
  end
  end
end
