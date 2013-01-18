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
			upload(params[:file][:filename], params[:file][:tempfile]) if params[:file] && params[:file][:filename]
			asset = Asset.new()
			asset.path = params[:file][:filename] if params[:file] && params[:file][:filename]
			halt 400, form_errors.from_model(asset.errors).to_json unless asset.valid? and asset.save
		end

		delete '/assets/:asset_id/?' do
			content_type 'application/json'
			asset = Asset.get(params[:asset_id])
			asset.destroy
		end



	end
end
