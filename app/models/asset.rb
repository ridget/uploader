class Asset
	include DataMapper::Resource

	before :save do |asset|
		asset.create_full_path
	end

	property	:id,		Serial
	property 	:path,  String, :required => true, :index => true, :length => 255
	property  :full_path, String, :length => 255

	def create_full_path
		self.full_path = ENV['S3_PATH'] + self.path
	end

end

