class AddReadersToBooks < ActiveRecord::Migration
  def change
  	add_reference :books, :reader, index: true, foreign_key: true
  end
end
