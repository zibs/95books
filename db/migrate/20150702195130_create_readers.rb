class CreateReaders < ActiveRecord::Migration
  def change
    create_table :readers do |t|
      t.string :name
      t.text :tweet_content, array: true
      t.timestamps null: false
  end
end
end

