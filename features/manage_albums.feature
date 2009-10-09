@album
Feature: Manage albums
	In order to make a galery
	As an author
	I want to create and manage albums

	Background:
		Given I am loged in as admin
  
  Scenario: Create new album
    Given I am on the new album page
    When I fill in "album.title" with "title 1"
    And I fill in "album.description" with "description 1"
    And I press "submit"
    Then I should see "albums.flash.created"
    And I should see "albums.add_photos.title"

  Scenario: Delete album
    Given I have albus titled Natural, Natural_1 in "Nature" category
    When I delete the "Natural" album
		Then I should have 1 album in "Nature" category
		And I should see "Natural_1"
