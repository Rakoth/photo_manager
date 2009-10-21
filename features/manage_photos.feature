Feature: Manage photos
	In order to create galery
	As an admin
	I want to manage photos

	Background:
		Given I am logged in as admin
		
	Scenario Outline: Creating photo
    Given I am on the new photo page
			And I attach the file as "<type>" at "spec/fixtures/images/test.gif" to "photo.image"
			And I fill in "photo.description" with "description 1"
			And I <bathe> "photo.bathe"
			And I press "submit"
    Then I should see "<message>"
		Examples:
			| type       | bathe   | description    | message                      |
			| image/gif  | check   | My first photo | photos.flash.created         |
			| image/gif  | uncheck | My first photo | photos.flash.created         |
			| plain/text | check   | My first photo | photos.flash.creating_failed |