#@codekit-prepend('../views/asset_item_view')
#	@codekit-prepend('../models/asset.coffee')

class window.AssetItem extends Spine.Controller

	events:
		'click .destroyed'		: 'remove'


	constructor : ->
		super
		@item.bind('update', @render)
		@item.bind('destroy', @release)

	template		: (item) ->
		_.template(window.AssetItemView, {'asset' : item})

	render			: =>
		@replace(@template(@item))
		@

	remove			: (event) =>
		event.preventDefault()
		@item.destroy()