module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the homepage/
      '/'

    when /the new purchase page/
			photo = Photo.first || Factory.create(:photo)
      new_photo_purchase_path(photo)
    when /the list of purchases page/
      purchases_path

    when /the new photo page/
      new_photo_path
    when /the "(.*?)" photo page/
      photo_path(Photo.find_by_description($1))
    when /the buy "(.*?)" photo page/
      buy_photo_path(Photo.find_by_description($1))

    when /the new order page/
      new_order_path
		when /the list of orders page/
			orders_path

    when /the new category page/
      new_category_path
		when /the list of categories/
			categories_path
		when /"(.*?)" category page/
			category_path(Category.find_by_title($1))
		when /edit "(.*?)" category page/
			edit_category_path(Category.find_by_title($1))

    when /the new album page/
      new_album_path
		when /the list of albums/
			albums_path
		when /add photos to "(.*?)" album page/
			add_photos_album_path(Album.find_by_title($1))
		when /^"(.*?)" album page/
			album_path(Album.find_by_title($1))
		when /edit "(.*?)" album page/
			edit_album_path(Album.find_by_title($1))
    
    # Add more mappings here.
    # Here is a more fancy example:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
