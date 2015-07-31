class NinetyfiversController < ApplicationController
	

	def index 

		@all_readers     = Reader.all 
		@books           = Book.all
		@grouped_readers = @all_readers.in_groups_of(2, false)

		# TWITTER AUTHORIZATION
		@twitter_client = Twitter::REST::Client.new do |config|
			 config.consumer_key        = ENV["YOUR_CONSUMER_KEY"]
			 config.consumer_secret     = ENV["YOUR_CONSUMER_SECRET"]
			 config.access_token        = ENV["YOUR_ACCESS_TOKEN"]
			 config.access_token_secret = ENV["YOUR_ACCESS_SECRET"]
		end
		
	# Eventually will be my backgroundjob
		# collect_readers
		# collect_books

	end

end


# https://github.com/javan/whenever