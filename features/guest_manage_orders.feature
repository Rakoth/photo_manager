@order
Feature: Manage orders
	In order to make a order for photosession
	As an guest
	I want to create order

  Scenario Outline: Register new order
    Given I am on the new order page
			And I have no orders
		When I fill in the following:
			| order.name        | <name>        |
			| order.phone       | <phone>       |
			| order.icq         | <icq>         |
			| order.email       | <email>       |
			| order.description | <description> |
			And I press "submit"
    Then I should see "<message>"
			And I should have <count> orders
		Examples:
			| name  | email         | phone        | icq    | description  | message                      | count |
			| guest | email@test.te | +70000000001 | 100100 | description1 | orders.flash.created         |   1   |
			| guest |               | +70000000001 | 100100 | description1 | orders.flash.creating_failed |   0   |
			| guest | invalid       | +70000000001 | 100100 | description1 | orders.flash.creating_failed |   0   |