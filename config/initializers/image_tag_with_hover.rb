module ActionView
  module Helpers
		module AssetTagHelper
			def image_tag_with_hover path, options = {}
				image_tag_without_hover path, {:mouseover => image_path(path.gsub('.', '_hover.'))}.merge(options)
			end

			alias_method_chain :image_tag, :hover
			alias_method :image_tag, :image_tag_without_hover
		end
	end
end