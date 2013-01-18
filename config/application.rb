Dir.glob(File.expand_path('../../lib/helpers/**', __FILE__), &method(:require))
Dir.glob(File.expand_path('../../app/app**', __FILE__), &method(:require))