class NinetyfiversController < ApplicationController

	def index 
		@all_readers = Reader.select("readers.*").joins(:books).group("readers.id").having("count(books.id) >= ?", 1)
		@paged_readers = @all_readers.paginate(:page => params[:page], :per_page => 14)			
		
		# TWITTER AUTHORIZATION
		@twitter_client = Twitter::REST::Client.new do |config|
			 config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
			 config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
			 config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
			 config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
		end
		collect_readers
		collect_books
		# selective_book_search(" Chroniques de Jérusalem by Guy Delisle.",49)
		# collect_books_each_tweet_of_reader(21)
	end
	def answers
	end
end

