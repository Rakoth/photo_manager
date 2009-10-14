module PhotosHelper
	def next_photo_link photo
		link_to hover_image_tag('icons/forward.png'), photo.next, :title => t(:next_photo) unless photo.next.nil?
	end

	def previous_photo_link photo
		link_to hover_image_tag('icons/back.png'), photo.previous, :title => t(:previous_photo) unless photo.previous.nil?
	end

	def this_album_link album
		link_to hover_image_tag('icons/album.png') + album.title, album, :title => t(:current_album)
	end

	def photo_image some_photo, style
		image_tag some_photo.image.url(style)
	end
end
