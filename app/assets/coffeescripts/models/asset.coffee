class window.Asset extends Spine.Model
	@configure 'Asset', 'path', 'full_path'

	@extend Spine.Model.Ajax

	@url = "http://uploader.dev/assets"

	constructor	: ->
		super
