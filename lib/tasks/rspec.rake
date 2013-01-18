namespace :spec do
	
	task :all => :rspec do
		RSpec::Core::RakeTask.new do |test|
  		test.pattern = "./spec/**/*_spec.rb"
		end
	end
	
	desc 'run models specifications'
	task :models => :rspec do
		RSpec::Core::RakeTask.new do |test|
			test.pattern = "./spec/**/models/*_spec.rb"
		end
	end
	
	desc 'run app specifications'
	task :app => :rspec do
		RSpec::Core::RakeTask.new do |test|
			test.pattern = "./spec/**/app/*_spec.rb"
		end
	end
	
end

desc 'run all specifications'
task :spec => 'spec:all'