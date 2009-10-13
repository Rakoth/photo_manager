@album
Feature: Guest Manage Albums
	In order to see a galery
	As an guest
	I want to see albums

	Scenario: Albums List
		Given I have albums:
			| title  |
			| First  |
			| Second |
		When I go to the list of albums
		Then I should see a link to "First" album
			And I should see a link to "Second" album

	Scenario: Show single Album
		Given I have album:
			| title  | description  |
			| First  | First photos |
			And I have some photos in "First" album
			And I am on "First" album page
		Then I should see "First"
			And I should see "First photos"
			And I should see links to all photos in "First" album