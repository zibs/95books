class Reader < ActiveRecord::Base
	has_many  :books, dependent: :destroy
	validates :name,  		   presence: true, uniqueness: { case_sensitive: false }
	validates :tweet_content,  presence: true, uniqueness: { case_sensitive: false }
end


# requires to save the tweet in an array at first, and that needs tweet content in order to be saved anyways...