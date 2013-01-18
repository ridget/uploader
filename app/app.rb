module Application

	class App < Sinatra::Base

		get '/' do
			@assets = Asset.all
			erb :index
		end

		get '/assets/?' do
			content_type 'application/json'
			200
		end

		post '/upload/?' do
			File.open('uploads/' + params[:file][:filename], "w") do |f|
  			f.write(params[:file][:tempfile].read)
			end
			asset = Asset.new(:path => params[:file][:filename])
			asset.save
		end

		delete '/assets/:asset_id/?' do
			content_type 'application/json'
			asset = Asset.get(params[:asset_id])
			asset.destroy
		end



	end
end
