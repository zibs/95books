class NinetyfiversController < ApplicationController

	def index 
		@displayable_readers = Reader.select("readers.*").joins(:books).group("readers.id").having("count(books.id) >= ?", 1).where("books.displayable = ?", true).order("RANDOM()").all
		@paged_readers = @displayable_readers.paginate(:page => params[:page], :per_page => 14)			
		# selective_book_search(" Chroniques de Jérusalem by Guy Delisle.",49)
		# collect_books_each_tweet_of_reader(21)
	end

	def answers
	end


end

	