class Book < ActiveRecord::Base
	has_and_belongs_to_many :readers

	validates   :author, 		    presence: true
	validates   :title,    			presence: true
	validates   :publisher, 		presence: true 
	validates 	:hashed_book,	    presence: true, uniqueness: { case_sensitive: false }
	scope		:displayable, -> { where(displayable: true) }

end



