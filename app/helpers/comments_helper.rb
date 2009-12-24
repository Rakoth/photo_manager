module CommentsHelper
	def gravatar comment, options = {}
		options[:size] ||= '45x45'
		image_tag url_for(comment.gravatar_options), options
	end

	def author_name comment
		if comment.author_url.blank?
			h comment.author
		else
			link_to h(comment.author), h(comment.author_url), :target => :blank
		end
	end
end
