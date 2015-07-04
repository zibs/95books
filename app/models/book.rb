class Book < ActiveRecord::Base
	has_and_belongs_to_many :readers

	validates   :author,    presence: true
	validates   :title,     presence: true
	validates   :publisher, presence: true
end
