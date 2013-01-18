class Uploader
	def initialize(filename, file)
    bucket = 'bucket_name'
    AWS::S3::Base.establish_connection!(
      :access_key_id     => ENV['ACCESS_KEY'],
      :secret_access_key => ENV['SECRET_ACCESS_KEY'],
      :server => ENV['SERVER'],
      :port => "10001"
    )
    AWS::S3::S3Object.store(
      filename,
      open(file.path),
      bucket
    )
    return filename
  end
end


module Sinatra
	module Helpers
		def upload(filename, file)
			@uploader = Uploader.new(filename, file)
		end

	end
end