module AlbumsHelper
	def add_photo_link name, container_id
		link_to_function name do |page|
			page.insert_html :bottom, container_id, :partial => 'photo', :object => Photo.new
		end
	end

	def this_category_link category
		unless category.nil?
			link_to image_tag_with_hover('icons/category.png') + category.title, category_path(category), :title => t(:current_category)
		end
	end

	def time_viewer object
		content_tag :span do
			"#{content_tag :strong, t(:created)}: #{l(object.created_at, :format => :long)};&nbsp;" +
				"#{content_tag :strong, t(:updated)}: #{l(object.updated_at, :format => :long)}"
		end
	end
end
