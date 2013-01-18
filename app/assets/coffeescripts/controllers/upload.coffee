#	@codekit-prepend('../views/file.coffee')
#	@codekit-prepend('../models/file.coffee')

class window.Upload extends Spine.Controller
	
	events:
		'click	.destroy'				: 'remove'	
	
	constructor	: ->
		super
		@item.bind('update', @render)
		@item.bind('destroy', @release)
	
	template		: (item) ->
		_.template(window.FileTemplate, {'file' : item})
	
	render			: =>
		@replace(@template(@item))
		@
	
	remove			: (event) ->
		event.preventDefault()
		@item.destroy()
	
