@order
Feature: Manage orders
	In order to see orders for photosession
	As an admin
	I want to manage orders

	Background:
		Given I am logged in as admin
  
  Scenario: Show orders List
		Given I have orders:
			| name       | email          |
			| customer 1 | email1@test.te |
			| customer 2 | email2@test.te |
			And I am on the homepage
			And I follow "Orders"
		Then I should see "orders.index.title"
			And I should see "customer 1"
			And I should see "customer 2"
			And I should see "email1@test.te"
			And I should see "email2@test.te"

	Scenario: Delete all expired orders
		Given I have some expired orders
			And I am on the list of orders page
		When I follow "Delete expired orders"
		Then I should see "orders.flash.expired_deleted"
			And I should have no expired orders


