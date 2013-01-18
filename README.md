#	Sinatra Boilerplate

[![Build Status](https://secure.travis-ci.org/theidealab/sinatra-boilerplate.png)](http://travis-ci.org/theidealab/sinatra-boilerplate)

Sinatra, Datamapper, and Rspec in an easy to use template.

##	Getting Started

Clone

	git clone git@github.com:theidealab/sinatra-boilerplate.git

Remove this remote

	git remote rm origin

Add your own remote

	git remote add origin git@github.com:my_org/my_repo.git

Start working, and modify `lib/tasks/setup.rake` to include tasks needed to setup your application when cloning.

##	Structure

###	`app/assets/{coffee, scss, etc}`
All your application specific assets.

###	`app/models`
Datamapper models which are automatically loaded into the application.

###	`app/views`
Views, layouts, and partials.

###	`config/`
Configuration for the database (`database.yml`), memcached (`memcached.yml`), and other application options (`application.rb`).

###	`db/{fixtures}`
Database fixtures for seeding the database. Update `db/seed.rb` for use via rake.

###	`lib/assets/{coffee, scss, etc}`
Common assets through multiple applications.

###	`lib/helpers`
Sinatra helpers which are automatically loaded into the application.

###	`lib/tasks`
Rake tasks which are automatically loaded by rake.

###	`spec/{app, models}`
RSpec tests for the application and models.

###	`vendor/assets/{coffee, scss, etc}`
Third party assets used in the application.
