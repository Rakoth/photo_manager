@album
Feature: Guest Manage Albums
	In order to see a galery
	As an guest
	I want to see photos

	Scenario Outline: Show single Photo
		Given I have photo:
			| description  | bathe   |
			| First photo  | <bathe> |
			And I am on the photo page
		Then I should see photo image with "normal" style
			And I should <see> "<message>"
		Examples:
			| bathe | see     | message     |
			| true  | see     | bathe_photo |
			| false | not see | bathe_photo |

	Scenario: See buy photo page
		Given I have photo:
			| description  | bathe |
			| First photo  | true  |
			And I am on the photo page
		When I follow "bathe_photo"
		Then I should see "photos.buy.title"