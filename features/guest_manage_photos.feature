@album
Feature: Guest Manage Albums
	In order to see a galery
	As an guest
	I want to see photos

	Scenario Outline: Show single Photo
		Given I have photo:
			| description  | bathe   |
			| First photo  | <bathe> |
			And I am on the "First photo" photo page
		Then I should see photo image with "normal" style
			And I should <see> "<message>"
		Examples:
			| bathe | see     | message     |
			| true  | see     | buy_photo |
			| false | not see | buy_photo |

	Scenario: See buy photo page
		Given I have photo:
			| description  | bathe |
			| First photo  | true  |
			And I am on the "First photo" photo page
		When I follow "buy_photo"
		Then I should see "purchases.new.title"
