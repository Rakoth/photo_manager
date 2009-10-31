Feature: Guest Manage purchases
	In order to buy a photos
	As an guest
	I want to create requests for buying photo

  Scenario Outline: Register new purchase
    Given I am on the new purchase page
			And I have no purchases
		When I fill in the following:
			| contact.name         | <name>  |
			| contact.phone        | <phone> |
			| contact.icq          | <icq>   |
			| contact.email        | <email> |
			| purchase.description | <email> |
			And I press "submit"
    Then I should see "<message>"
			And I should have <count> purchases
		Examples:
			| name  | email         | phone        | icq    | message                         | count |
			| guest | email@test.te | +70000000001 | 100100 | purchases.flash.created         |   1   |
			| guest |               | +70000000001 | 100100 | purchases.flash.creating_failed |   0   |
			| guest | invalid       | +70000000001 | 100100 | purchases.flash.creating_failed |   0   |
