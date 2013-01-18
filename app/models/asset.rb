class Asset
	include DataMapper::Resource

	property	:id,		Serial
	property 	:path,  String, :required => true, :index => true

	def full_path
		ENV['S3_PATH'] + path
	end
end

