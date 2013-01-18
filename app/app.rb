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
			upload(params[:file][:filename], params[:file][:tempfile])
			asset = Asset.new()
			asset.path = params[:file][:filename]
			asset.save
		end

		delete '/assets/:asset_id/?' do
			content_type 'application/json'
			asset = Asset.get(params[:asset_id])
			asset.destroy
		end



	end
end
