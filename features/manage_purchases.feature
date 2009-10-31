@order
Feature: Manage orders
	In order to see photo purchase requests
	As an admin
	I want to manage purchases

	Background:
		Given I am logged in as admin
  
  Scenario: Show purchases List
		Given I have purchases:
			| description |
			| descriptio1 |
			| descriptio2 |
			And I am on the homepage
			And I follow "Purchases"
		Then I should see "purchases.index.title"
			And I should see "descriptio1"
			And I should see "descriptio2"

	Scenario: Delete all purchases
		Given I have some purchases
			And I am on the list of purchases page
		When I follow "Delete purchases"
		Then I should see "purchases.flash.deleted"
			And I should have no purchases


