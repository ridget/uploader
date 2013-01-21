#@codekit-prepend('controllers/upload.coffee')
#@codekit-prepend('models/asset.coffee')
###
#	requires Spine, Filedrop, and SWFupload
###

class window.Uploader extends Spine.Controller

	elements:
		'#global_progress': 'global_progress'
		'#upload_list'		: 'upload_list'

	constructor		: (options = {})->
		super

		@options = options

		@.bind('upload_error', @upload_error)
		@.bind('complete_upload', @complete_upload)
		@.bind('update_upload', @update_upload)

		File.bind('create', @add_upload)
		File.bind('destroy', @remove_upload)

		@defaults =
			'fallback_id'			: 'file_select'
			'post_url'				: '/assets'
			'post_param'			: 'file'
			'max_files'				: 1000
			'max_file_size'		: 3000
			'post_data'				: {}
			'post_headers'		: {}

		if typeof FileReader != 'undefined' && 'draggable' of document.createElement('span')
			@use_upchunk(@defaults, @options)
		else if swfobject.hasFlashPlayerVersion('9.0.24')
			@use_swfupload(@defaults, @options)



	add_upload		: (file) =>
		view = new Upload('item' : file)
		@upload_list.append(view.render().el)

	remove_upload	: (file) =>
		if file.swf_id && @swf_upload
			unless file.complete
				@swf_upload.cancelUpload(file.swf_id, false)

	update_upload	: (event) ->
		# upload has been updated
		# event.file
		# event.progress

	complete_upload	: (event) =>
		asset = Asset.refresh(event.asset)
		File.destroy(event.file.id)

		# upload has completed
		# event.file



	upload_error	: (error) ->
		switch error
			when 'BrowserNotSupported'
				console.log 'browser not supported'
			when 'TooManyFiles' || 'QUEUE_LIMIT_EXCEEDED' || 'FILE_VALIDATION_FAILED' || 'UploadHalted'
				console.log 'too many files'
			when 'FileTooLarge' || 'FILE_EXCEEDS_SIZE_LIMIT'
				console.log 'file too large'
			when 'FileTypeNotAllowed' || 'ZERO_BYTE_FILE'
				console.log 'file type not allowed'
			when 'ZERO_BYTE_FILE'
				console.log 'empty files are not allowed'
			else
				console.log 'generic error'

	update_global_progress	: (progress) ->
		@global_progress.width("#{progress}%")

	use_upchunk	: (defaults = {}, options = {}) ->
		$(document).upchunk({
			'fallback_id'			: options.fallback_id		|| defaults.fallback_id
			'url'							: options.post_url			|| defaults.post_url
			'file_param'			: options.post_param		|| defaults.post_param
			'max_file_size'		: options.max_file_size	|| defaults.max_file_size
			'data'						: options.post_data			|| defaults.post_data				|| {}
			'headers'					: options.post_headers	|| defaults.post_headers		|| {}
			'queue_size'			: 3

			'docEnter'				: ->
				# document has been entered

			'docLeave'				: ->
				# document has been left

			'beforeEach'			: (file)  =>
				if File.count() >= (options.max_files	 || defaults.max_files)
					@trigger 'upload_error', {
						'error'	: 'TooManyFiles'
						'file'	: file
					}
					return false

			'uploadStarted'		: (file,hash) ->
				File.create({
					'name'		: file.name
					'size'		: file.size
				})

			'progressUpdated'	: (file,hash, progress) =>
				upload = File.findByAttribute('name', file.name)
				upload.progress = progress
				upload.save()
				@trigger 'update_upload', {
					'file'		: file
					'progress': progress
				}

			#'speedUpdated'		: (i, file, speed) ->
			#	upload = File.findByAttribute('name', file.name)
			#	upload.speed = speed
			#	upload.save()

			'uploadFinished'	: (file,hash,response) =>
				upload = File.findByAttribute('name', file.name)
				if response
					upload.progress	= 100
					upload.complete	= true
					upload.save()
					@trigger 'complete_upload', {
						'file'	: upload
						'asset' : response

					}
				else
					upload.destroy()
					@trigger 'upload_error', {
						'error'	: 'unknown'
					}

			'error'						: (error) =>
				@trigger 'upload_error', {
					'error'	: error
				}


			#'globalProgressUpdated'	: (progress) =>
			#	@update_global_progress(progress)
			#
		})



	use_swfupload	: (defaults = {}, options = {}) ->
		@swf_upload = new SWFUpload
			#'button_action'					: SWFUpload.BUTTON_ACTION.SELECT_FILES
			'flash_url'							: '/javascripts/vendor/swfupload/swfupload.swf'
			'button_width'					: 61
			'button_height'					: 22
			'button_placeholder_id'	: options.fallback_id		|| defaults.fallback_id
			'upload_url'						: options.post_url			|| defaults.post_url
			'file_post_name'				: options.post_param		|| defaults.post_param
			'file_upload_limit'			: 999
			'file_size_limit'				: options.max_file_size	|| defaults.max_file_size
			'post_params'						: options.post_data			|| defaults.post_data
			'debug'									: true

			'file_queue_error_handler'	: (file, code, error) =>
				error = _.invert(SWFUpload.QUEUE_ERROR)[code]
				@trigger 'upload_error', {
					'error'	: error
					'file'	: file
				}

			'upload_start_handler'	: (file) =>
				if File.count() >= (options.max_files	 || defaults.max_files)
					@trigger 'upload_error', {
						'error'	: 'TooManyFiles'
						'file'	: file
					}
					return false

				if file
					File.create({
						'name'		: file.name
						'size'		: file.size
						'swf_id'	: file.id
					})

			'upload_progress_handler'	: (file, uploaded, total) =>
				upload = File.findByAttribute('name', file.name)
				upload.progress = (uploaded/total) * 100
				upload.save()
				@trigger 'update_upload', {
					'file'		: file
					'progress': (uploaded/total) * 100
				}

			'upload_success_handler'	: (file) =>
				upload = File.findByAttribute('name', file.name)
				upload.progress	= 100
				upload.complete	= true
				upload.save()
				@trigger 'update_complete', {
					'file'		: file
				}

			'upload_error_handler'		: (file, code, error) =>
				if file
					upload = File.findByAttribute('name', file.name)
					upload.destroy()
					error = _.invert(SWFUpload.UPLOAD_ERROR)[code]
					@trigger 'upload_error', {
						'error'	: error
						'file'	: file
					}


			'file_dialog_complete_handler'	: (args...) =>
				@swf_upload.startUpload()



