###
# helper method for memcached access
# memcached.set		'my_key', 'my_value'
# memcached.get		'my_key'							# returns 'my_value'
#
# if a memcached server doesn't exist / isn't found emulates Dalli's functionality with empty methods
#

module Sinatra
	module Helpers
		
		def memcached
			if ENV['MEMCACHED_LOCATION']
				@memcached_client ||= Dalli::Client.new ENV['MEMCACHED_LOCATION']
			else
				@memcached_client ||= Class.new do
					def self.set (key, value)
						nil
					end
					
					def self.get (key)
						nil
					end
				end
			end
		end
		
	end
end