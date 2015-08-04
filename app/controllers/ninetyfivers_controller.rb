class NinetyfiversController < ApplicationController
	

	def index 
		@all_readers = Reader.select("readers.*").joins(:books).group("readers.id").having("count(books.id) >= ?", 1).includes(:latest_book).all
		@paged_readers = @all_readers.paginate(:page => params[:page], :per_page => 15)			
		# @books           = Book.all
		# @grouped_readers = @all_readers.in_groups_of(2, false)

		# TWITTER AUTHORIZATION
		@twitter_client = Twitter::REST::Client.new do |config|
			 config.consumer_key        = ENV["YOUR_CONSUMER_KEY"]
			 config.consumer_secret     = ENV["YOUR_CONSUMER_SECRET"]
			 config.access_token        = ENV["YOUR_ACCESS_TOKEN"]
			 config.access_token_secret = ENV["YOUR_ACCESS_SECRET"]
		end
		
	
		# collect_readers
		# collect_books
		# selective_book_search(" Chroniques de Jérusalem by Guy Delisle.",49)
		# collect_books_each_tweet_of_reader(21)
	end

end

