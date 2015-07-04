module NinetyfiversHelper
	require 'mechanize'
	require 'nokogiri'
	# look into named_captures
	AUTHOR = /(by\s|-+\s?|\(+\s?|of\s?|[^RT]\s@\b)(([a-zA-Z,.'-]+\s?){1,3})/
	BOOK_TITLE = /(([a-zA-Z,.'-]+\s?){1,4})(by\s|-+\s?|\(+\s?|of\s?|[^RT]\s@\b)/

		# 
	def collect_readers
		 	@client.search('#95books').each do |tweet|
		 		@tweet_user    = tweet.user.name
		 		@tweet_content = tweet.text
				@new_reader = Reader.create(name: @tweet_user, tweet_content: [@tweet_content]) unless Reader.exists?(name: @tweet_user)
				# make case where we have to upsert tweet content
				
		end
	end

	def collect_books 	

		@Readers.each do |reader|

			@hashtag_tweet=reader.tweet_content.last
				if webscrape_possible(@hashtag_tweet)
					webscrape_publishing_house(@book_title_match, @author_match)
					reader.books.create(author: @author_match, title: @book_title_match, publisher: @publisher)
				else
				# cannot scrape, do what? figure out mailer for this option?? 

			end
		end
	end

	def webscrape_possible(hashtag_tweet)
		if tweet_contains_author?(hashtag_tweet) && tweet_contains_book_title?(hashtag_tweet)
		 @author_match = hashtag_tweet.match(AUTHOR)[2].strip
		 @book_title_match=hashtag_tweet.match(BOOK_TITLE)[1].gsub(".","").strip 
 		end
	end

	def tweet_contains_author?(hashtag_tweet)
		 hashtag_tweet.match(AUTHOR)
		end

	def tweet_contains_book_title?(hashtag_tweet)
		 hashtag_tweet.match(BOOK_TITLE)
		end


	def webscrape_publishing_house(title_of_book, author_of_book)
		a = Mechanize.new { |agent|
		  agent.user_agent_alias = 'Mac Safari'
		}
		 a.get('http://google.com/') do |page|
			 search_results = page.form_with(:name => 'f') do |search|
		     search.q="#{title_of_book} by #{author_of_book} Amazon"
		  end.submit
		  if search_results.link_with(:text=> /(Amazon.ca|Amazon.com #{Regexp.quote(title_of_book)} #{Regexp.quote(author_of_book)})/)
		   amazon_result = search_results.link_with(:text=> /(Amazon.ca|Amazon.com #{Regexp.quote(title_of_book)}-#{Regexp.quote(author_of_book)})/).click 
		   if amazon_result.uri.to_s.match(/.ca/) && amazon_result.search("#detail_bullets_id").at("li:contains('Publisher:')")
	    		@publisher = amazon_result.search("#detail_bullets_id").at("li:contains('Publisher:')").text 	
	    	elsif amazon_result.link_with(:text=>/#{Regexp.quote(title_of_book)}/)
	    		inner_amazonca = amazon_result.link_with(:text=>/#{Regexp.quote(title_of_book)}/).click
	    		@publisher = inner_amazonca.search("#detail_bullets_id").at("li:contains('Publisher:')").text
	    	elsif 
	    		amazon_result.uri.to_s.match(/.com/) && amazon_result.search("#detail-bullets").at("li:contains('Publisher: ')")
	    		@publisher = amazon_result.search("#detail-bullets").at("li:contains('Publisher:')").text 	
	    	elsif amazon_result.uri.to_s.match(/.com/) &&  amazon_result.link_with(:text=>/#{Regexp.quote(title_of_book)}/)
	    			inner_amazoncom = amazon_result.link_with(:text=>/#{Regexp.quote(title_of_book)}/).click
	    		@publisher = inner_amazoncom.search("#detail-bullets").at("li:contains('Publisher:')").text 	
	    	else
	    		@publisher = "undiggable!"
	    	end
	    else @publisher = "Google initial search ain't panning"
	    end
	    return @publisher
		end
	end
			
end
