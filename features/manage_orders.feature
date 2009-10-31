@order
Feature: Manage orders
	In order to see orders for photosession
	As an admin
	I want to manage orders

	Background:
		Given I am logged in as admin
  
  Scenario: Show orders List
		Given I have orders:
			| place | description |
			| plac1 | descriptio1 |
			| plac2 | descriptio2 |
			And I am on the homepage
			And I follow "Orders"
		Then I should see "orders.index.title"
			And I should see "plac1"
			And I should see "plac2"
			And I should see "descriptio1"
			And I should see "descriptio2"

	Scenario: Delete all expired orders
		Given I have some expired orders
			And I am on the list of orders page
		When I follow "Delete expired orders"
		Then I should see "orders.flash.expired_deleted"
			And I should have no expired orders


