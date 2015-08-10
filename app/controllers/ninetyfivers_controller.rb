class NinetyfiversController < ApplicationController

	def index 
		@all_readers = Reader.select("readers.*").joins(:books).group("readers.id").having("count(books.id) >= ?", 1).where("books.displayable = ?", true)
		@paged_readers = @all_readers.paginate(:page => params[:page], :per_page => 14)			
		# selective_book_search(" Chroniques de Jérusalem by Guy Delisle.",49)
		# collect_books_each_tweet_of_reader(21)
	end

	def answers
	end


end

