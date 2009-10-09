@category
Feature: Manage Categories
	In order to make a galery
	As an author
	I want to create and manage categories

	Background:
		Given I am loged in as admin

	Scenario: Create valid category
		Given I am on the new category page
		When I fill in the following:
		| category.title       | City            |
		| category.description | City and people |
		And I attach the file at "spec/fixtures/images/test.gif" to "category.title_image" with content type "image/gif"
		And I press "submit"
		Then I should see "City"
		And I should see "City and people"

	Scenario: Delete category
    Given I have categories titled Nature, Walk
    When I delete the category, titled "Nature"
		Then I should have 1 category
		And I should see a link to category, titled "Walk"
