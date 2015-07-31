class Reader < ActiveRecord::Base
	has_many  :books, dependent: :destroy
	# attr_accessor :name, :tweet_content
	validates :name,  		   presence: true, uniqueness: { case_sensitive: false }
	validates :tweet_content,  presence: true 
	# checks uniqueness over all of it, not each one.. 


end


# requires to save the tweet in an array at first, and that needs tweet content in order to be saved anyways...