class NinetyfiversController < ApplicationController
	def index 
		@Readers = Reader.all 
		@client = Twitter::REST::Client.new do |config|
			 config.consumer_key        = ENV["YOUR_CONSUMER_KEY"]
			 config.consumer_secret     = ENV["YOUR_CONSUMER_SECRET"]
			 config.access_token        = ENV["YOUR_ACCESS_TOKEN"]
			 config.access_token_secret = ENV["YOUR_ACCESS_SECRET"]
		end

	# Eventually will be my backgroundjob
		collect_readers
		collect_books
		# email_eli_for_corrections

	 # Will need to display readers in view


	end

end
