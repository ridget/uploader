source	:rubygems

# Framework
gem			'sinatra',					:require => 'sinatra/base'
gem			'rack-flash3',			:require => 'rack-flash'

# Logging
gem			'log4r'

# Security
gem			'bcrypt-ruby',			:require => 'bcrypt'

# Database
gem			'dm-core'
gem			'dm-migrations'
gem			'dm-timestamps'
gem			'dm-validations'
gem     'dm-serializer'

# Adapters
gem			'dm-sqlite-adapter'
#gem			'dm-postgres-adapter'
#gem			'dm-mysql-adapter'
#gem			'dm-redis-adapter'
#gem			'dm-mongo-adapter'

# Memcached
#gem			'dalli'
#gem			'kgio'

# Output
gem			'erubis'
gem			'yajl-ruby',			:require => 'yajl/json_gem'

# Utility
gem			'rake'


# s3

gem 'aws-s3'

group :test do
	# Coverage
	gem		'simplecov',			:require => false

	# Testing
	gem		'rspec'
	gem		'dm-rspec'
	gem		'nyan-cat-formatter'
	gem		'rack-test',			:require => 'rack/test'
end

group :test, :development do
	gem 'fakes3'
end