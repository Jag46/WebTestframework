@api @regression @ipc
Feature: Scenarios for App Id Gen endpoint

    Background: Generate JWT for use in token handler calls
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1711111"
        And I verify the response status code as "200"

    # *************************************************
    #              HAPPY PATH SCENARIOS
    # *************************************************

    @TestCaseKey=CAO-T612 @TestCaseKey=CAO-T613 @TestCaseKey=CAO-T614
    Scenario Outline: Call AppIdGen for generate IPC App ID for <appType> and <accountNumber> - HTTP 200
        Given I generate a token for appIdGen apptype "<appType>", productId "7002", new productId "7006", account number "<accountNumber>" and environmnet "dev4"
        And I verify the response status code as "302"
        When I set "GET" method for "appIdGen"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | productid | 7002 |
        And I set the headers for the request
            | location |  |
        And I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_idgen_channel       | <channelValue>  |
            | Response_idgen_productid     | 7002            |
            | Response_idgen_newproductid  | 7006            |
            | Response_idgen_accountnumber | <accountNumber> |
        Examples:
            | appType | channelValue        | accountNumber |
            | OLB     | INTERNET OLB-MOBILE | 12345678      |
            | OLB     | INTERNET OLB-MOBILE |               |
            | NGBA    | MOBILE              | 87654321      |


    # *************************************************
    #              ERROR SCENARIOS
    # *************************************************

    @TestCaseKey=CAO-T615 @TestCaseKey=CAO-T616
    Scenario Outline: Call AppIdGen with modified productId parameters <productId>- HTTP 400
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number "12345678" and environmnet "dev4"
        And I verify the response status code as "302"
        And I save "location" value from the "headers" future use
        When I set "GET" method for "appIdGen"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | productid | <productId> |
        And I set the headers for the request
            | location |  |
        And I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_type    | Input Error - Mismatch ProductId |
            | Response_error_retry   | true                             |
            | Response_error_message | Wrong ProductId                  |
        Examples:
            | productId |
            |           |
            | 7006      |

    @TestCaseKey=CAO-T617
    Scenario: Call AppIdGen with no location token - HTTP 401
        Given I set "GET" method for "appIdGen"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | productid | 7006 |
        When I send the request
        Then I verify the response status code as "401"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_type    | Input Error - Invalid ApiKey                    |
            | Response_error_retry   | true                                            |
            | Response_error_message | API Key is not available or can not be verified |

    @TestCaseKey=CAO-T618
    Scenario: Call AppIdGen with modified location token - HTTP 500
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number "12345678" and environmnet "dev4"
        And I verify the response status code as "302"
        And I save "location" value from the "headers" future use
        When I set "GET" method for "appIdGen"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | productid | 7006 |
        And I "update" the following global values
            | location | hfysdgfsd |
        And I set the headers for the request
            | location |  |
        And I send the request
        Then I verify the response status code as "500"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_type    | Internal Error        |
            | Response_error_retry   | true                  |
            | Response_error_message | Internal Server Error |


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
