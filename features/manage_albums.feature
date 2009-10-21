@album
Feature: Manage albums
	In order to make a galery
	As an author
	I want to create and manage albums

	Background:
		Given I am logged in as admin

	Scenario Outline: Creating album
    Given I am on the new album page
		When I fill in the following:
			| album.title       | <title>         |
			| album.description | description 1   |
			And I press "submit"
    Then I should see "<message>"
			And I should see "<page_title>"
		Examples:
			| title       | message              | page_title              |
			| Valid title | albums.flash.created | albums.add_photos.title |
			|             | messages.blank       | albums.new.title        |

	Scenario: Show add photo page
		Given I have album:
			| title       |
			| Album Title |
			And I am on "Album Title" album page
		When I follow "Add photos"
		Then I should see "photo.image"
			And I should see "albums.add_photos.title"

  Scenario: Add single photo to album
		Given I have album:
			| title       |
			| Album Title |
			And I have no photos
			And I am on add photos to "Album Title" album page
		When I attach the file as "image/gif" at "spec/fixtures/images/test.gif" to "photo.image"
			And I fill in "photo.description" with "description 1"
			And I press "submit"
		Then I should see "albums.flash.photos_added"
			And I should see "Album Title"
#			And I should have 1 photo in "Album Title" album

#	Scenario: Add invalid photo to album
#		Given I have Album Title album
#			And I am on add photos to "Album Title" album page
#		When I attach the file as "image/gif" at "spec/fixtures/images/test.txt" to "photo.image"
#			And I press "submit"
#		Then I should see "activerecord.errors.messages.invalid"
#			And I should see "albums.add_photos.title"

	Scenario Outline: Update album
		Given I have album:
			| title | description |
			| First | First one!  |
			And I am on the edit "First" album page
		When I fill in the following:
			| album.title       | <title>        |
			| album.description | First photos!  |
			And I press "submit"
		Then I should see "<message>"
			And I should see "First photos!"
		Examples:
			| title      | message              |
			| First one! | albums.flash.updated |
			|            | messages.blank       |

	Scenario Outline: <action> from edit album page
		Given I have album:
			| title | description |
			| First | First one!  |
			And I have 3 photos in "First" album
			And I am on the edit "First" album page
		When I check "<checkbox>"
			And I press "submit"
		Then I should have <result> in "First" album
		Examples:
			| action              | checkbox      | result        |
			| Delete photos       | photo._delete | 2 photos      |
			| Mark photo as bathe | photo.bathe   | 1 bathe photo |

  Scenario: Delete album
		Given I have albums:
			| title     |
			| Natural   |
			| Natural_1 |
    When I delete the "Natural" album
		Then I should have 1 album
			And I should see "Natural_1"
