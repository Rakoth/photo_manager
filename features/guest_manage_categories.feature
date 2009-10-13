@category
Feature: Guest Manage Categories
	In order to see a galery
	As an guest
	I want to see categories

	Scenario: Categories List
		Given I have categories:
			| title  | description    |
			| Nature | Natures photos |
			| Walk   | Walk photos    |
		When I go to the list of categories
		Then I should see a link to "Nature" category 
		And I should see a link to "Walk" category

	Scenario: Show single category
		Given I have category:
			| title  | description    |
			| Nature | Natures photos |
			And I have some albums in "Nature" category
			And I am on "Nature" category page
		Then I should see "Nature"
			And I should see "Natures photos"
			And I should see links to all albums in "Nature" category
