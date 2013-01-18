task :environment do
	require File.expand_path('../config/boot', __FILE__)
end

task :rspec do
	require 'rspec/core/rake_task'
end

task :bundler do
	require 'bundler'
end

Dir.glob(File.expand_path('../lib/tasks/**/*.rake', __FILE__), &method(:load))