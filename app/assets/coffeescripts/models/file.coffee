class window.File extends Spine.Model
	@configure 'File', 'name', 'complete', 'size', 'progress', 'speed', 'swf_id'

	constructor	: ->
		super
		@complete	= false
		@progress	= 0