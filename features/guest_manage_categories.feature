@category
Feature: Guest Manage Categories
	In order to see a galery
	As an guest
	I want to see categories

	Scenario: Categories List
		Given I have categories titled Nature, Walk
		When I go to the list of categories
		Then I should see a link to "Nature" category 
		And I should see a link to "Walk" category

	Scenario: Show single category
		Given I have category:
			| title  | description    |
			| Nature | Natures photos |
		And I am on "Nature" category page
		Then I should see "Nature"
		And I should see "Natures photos"
