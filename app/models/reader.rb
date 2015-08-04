class Reader < ActiveRecord::Base
	has_many  :books, dependent: :destroy
	validates :name,  		   presence: true, uniqueness: { case_sensitive: false }
	validates :tweet_content,  presence: true
	has_one :latest_book, -> { displayable.order(id: :desc).limit(1) },
		class_name: "Book"



end


