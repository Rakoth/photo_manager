module PhotosHelper
	def next_photo_link photo
		link_to image_tag('mail.gif'), photo.next, :title => t(:next_photo) unless photo.next.nil?
	end

	def previous_photo_link photo
		link_to image_tag('mail.gif'), photo.previous, :title => t(:previous_photo) unless photo.previous.nil?
	end

	def this_album_link album
		link_to image_tag('mail.gif') + album.title, album, :title => t(:current_album)
	end

	def photo_image some_photo, style
		image_tag some_photo.image.url(style)
	end
end
