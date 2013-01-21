#@codekit-prepend('controllers/asset_item')
#@codekit-prepend('models/asset')


class window.Assets extends Spine.Controller

	elements:
		'#asset_list' : 'asset_list'

	constructor	: ->
		super
		Asset.bind('create', @add_single_asset)
		Asset.bind('refresh', @add_all_assets)
		Asset.bind('update', @add_all_assets)
		@add_all_assets()


	add_single_asset : (asset) =>
		asset_view = new AssetItem('item' : asset)
		@asset_list.append(asset_view.render().el)


	add_all_assets : =>
		@asset_list.html ''
		Asset.each(@add_single_asset)