Feature: Manage Categories
	In order to make a galery
	As a author
	I want to create and manage categories

	Scenario: Categories List
		Given I have categories titled Природа, Прогулки на природе
		When I go to the list of categories
		Then I should see "Природа"
		And I should see "Прогулки на природе"
