@api @regression @ipc
Feature: Scenarios for the token handler exchange endpoint

    Background: Generate JWT for use in token handler calls
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1711111"
        And I verify the response status code as "200"

    # *************************************************
    #              HAPPY PATH SCENARIOS
    # *************************************************

    @TestCaseKey=CAO-T606
    Scenario: Call token handler exchange to return redirect - HTTP 302
        Given I set "POST" method for "tokenHandlerExchange"
        And I set the config for the request to "encoded"
        And I set the query parameters for the request
            | newproductid    | 7006 |
            | productid       | 7002 |
            | dctc            | 210  |
            | environmentName | dev4 |
        And I set the following encoded params
            | JwtToken  |          |
            | accountNo | 12345678 |
        When I send the request
        Then I verify the response status code as "302"
        And I verify the response headers
            | location | contains | token= |

    # *************************************************
    #              ERROR SCENARIOS
    # *************************************************

    @TestCaseKey=CAO-T607
    Scenario: Call token handler exchange with no jwtToken to not return redirect - HTTP 302
        Given I set "POST" method for "tokenHandlerExchange"
        And I set the config for the request to "encoded"
        And I set the query parameters for the request
            | newproductid    | 7006 |
            | productid       | 7002 |
            | dctc            | 210  |
            | environmentName | dev4 |
        And I set the following encoded params
            | accountNo | 12345678 |
        When I send the request
        Then I verify the response status code as "302"
        And I verify the response headers
            | location | equals | https://nbs-banking-webapp-ipc-int.dev4.edb-a.eu-west-2.notprod.thenbs.io |

    @TestCaseKey=CAO-T608 @TestCaseKey=CAO-T609
    Scenario Outline: Call token handler exchange with no params to return app unavailable <newProductIdValue>- HTTP 302
        Given I set "POST" method for "tokenHandlerExchange"
        And I set the config for the request to "encoded"
        And I set the query parameters for the request
            | <newProductIdValue> |
            | <productIdValue>    |
        And I set the following encoded params
            | JwtToken  |          |
            | accountNo | 12345678 |
        When I send the request
        Then I verify the response status code as "302"
        And I verify the response headers
            | location | equals | https://www.nationwide.co.uk/support/service/app-unavailable |
        Examples:
            | newProductIdValue | productIdValue |
            |                   |                |
            | 7006              |                |

    @TestCaseKey=CAO-T610 @TestCaseKey=CAO-T611
    Scenario Outline: Call token handler exchange with incorrect productId values to return discovery redirect <newProductIdValue>- HTTP 302
        Given I set "POST" method for "tokenHandlerExchange"
        And I set the config for the request to "encoded"
        And I set the query parameters for the request
            | newproductid    | <newProductIdValue> |
            | productid       | <productIdValue>    |
            | dctc            | 210                 |
            | environmentName | dev4                |
        And I set the following encoded params
            | JwtToken  |          |
            | accountNo | 12345678 |
        When I send the request
        Then I verify the response status code as "302"
        And I verify the response headers
            | location | contains | http://DVIBPITVW28/ProductSwitcher/ProductSwitcher/ApplicationRemote |
        Examples:
            | newProductIdValue | productIdValue |
            | 7002              | 7006           |
            | 7004              | 7002           |

# *************************************************
#              HEADERS ERROR SCENARIOS
# mandatory or optional Headers remove/empty/null values
# *************************************************



#*************************************************
#             REQUEST PAYLOAD
# mandatory or optional body remove/empty/null values
# *************************************************



#*************************************************
#                Miscellaneous
#             and Invlid EndPontURL
# *************************************************

#*************************************************
#             MAX Length Headder AND Body
# *************************************************


#*************************************************
#             ANTISAMY
#   Body or Headder having scripts
# *************************************************


#*************************************************
#HEADER & BODY SPECIAL CHARACTERS VALIDATIONS
# *************************************************

#*************************************************
#           E2E Scenarios
# *************************************************
