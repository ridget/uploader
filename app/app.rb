module Application

	class App < Sinatra::Base
		use Rack::Session::Cookie, :domain => ENV['APP_NAME']
		use Rack::Flash


		get '/' do
			@assets = Asset.all
			erb :index
		end

		get '/assets/?' do
			content_type 'application/json'
			200
		end

		post '/assets/?' do
			content_type 'application/json'
			filename = upload(params[:file][:filename], params[:file][:tempfile]) if params[:file] && params[:file][:filename]
			asset = Asset.new()
			asset.path = params[:file_name] if params[:file_name]
			halt 400, form_errors.from_model(asset.errors).to_json unless asset.valid? and asset.save
			asset.to_json
		end

		delete '/assets/:asset_id/?' do
			content_type 'application/json'
			asset = Asset.get(params[:asset_id])
			asset.destroy
		end



	end
end
