###
# helper method for form errors
# form_errors['field_name']	= 'error with this field'
# form_errors['field_name']	# error with this field
#

module Sinatra
	module Helpers

		class FormError
			def initialize(store)
				@store	= store
				sweep!
			end

			def [](key)
				key = key.to_sym
				cache[key] ||= values.delete(key)
			end

			def []=(key,val)
				key = key.to_sym
				cache[key] = values[key] = val
			end

			def length
				cache.keys.length
			end

			def from_model(model_errors)
				model_errors.keys.each do |key|
					self[key] = model_errors[key].first
				end
				self
			end

			def to_json
				values.to_json
			end

			private

			def cache
				@cache ||= {}
			end

			def values
				@store[:__FORMERRORS__] ||= {}
			end

			def sweep!
				values.keys.each do |key|
					cache[key] ||= values.delete(key)
				end
			end

		end

		def form_errors
			@form_errors ||= FormError.new env['rack.session']
		end

	end
end