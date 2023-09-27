@api @regression @ipc
Feature: Scenarios for Account Manager- Retrieve Account Details end point
    # Account Manager - /account-setup/v1/retrieveaccountdetails

    Background: Generate JWT for use in token handler calls
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1711111"
        And I verify the response status code as "200"

    # *************************************************
    #              HAPPY PATH SCENARIOS
    # *************************************************

    @happyPath  @TestCaseKey=CAO-T640
    Scenario: Call Get Account Details service for Joint Account Valid for X2X card: HTTP 200
        Given I set "GET" method for "accountDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 123456 10000001 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid          | 123456 10000001 |
            | Response_accountDetail_investorTypeCode    | J               |
            | Response_accountDetail_creditScore         | 4               |
            | Response_accountDetail_availableBalanceAmt | 100.00          |
            | Response_accountDetail_overdraftAmount     | 100.00          |

    @happyPath  @TestCaseKey=CAO-T641
    Scenario: Call Get Account Details service for account with Available balance > than the allowed overdraft limit: HTTP 200
        Given I set "GET" method for "accountDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 123456 10000005 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid          | 123456 10000005 |
            | Response_accountDetail_investorTypeCode    | O               |
            | Response_accountDetail_creditScore         | 4               |
            | Response_accountDetail_availableBalanceAmt | -100.01         |
            | Response_accountDetail_overdraftAmount     | 100.00          |

    @happyPath  @TestCaseKey=CAO-T642
    Scenario: Call Get Account Details service for account without overdraft limit: HTTP 200
        Given I set "GET" method for "accountDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 123456 10000007 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid                    | 123456 10000007 |
            | Response_accountDetail_investorTypeCode              | O               |
            | Response_accountDetail_creditScore                   | 4               |
            | Response_accountDetail_availableBalanceAmt           | 100.00          |
            | Response_accountDetail_accountInCollectionsIndicator | false           |
        And I verify the following param value is "api_null" with response param value
            | Response_accountDetail_overdraftAmount |  |

    @happyPath  @TestCaseKey=CAO-T1059
    Scenario: Call Get Account Details service for account with collections flag: HTTP 200
        Given I set "GET" method for "accountDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 123456 10000010 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid                    | 123456 10000010 |
            | Response_accountDetail_investorTypeCode              | O               |
            | Response_accountDetail_creditScore                   | 4               |
            | Response_accountDetail_accountInCollectionsIndicator | true            |

    @happyPath  @TestCaseKey=CAO-T643
    Scenario: Call Get Account Details service for default scenario Sole account, facility level = 4 & Positive balance: HTTP 200
        Given I set "GET" method for "accountDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100044 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid          | 100044 12345678 |
            | Response_accountDetail_investorTypeCode    | O               |
            | Response_accountDetail_creditScore         | 4               |
            | Response_accountDetail_availableBalanceAmt | 100.00          |
            | Response_accountDetail_overdraftAmount     | 100.00          |

    # *************************************************
    #              ERROR SCENARIOS
    # *************************************************

    @400  @error    @TestCaseKey=CAO-T644
    Scenario: Call Get Account Details service with special characters in account Id: HTTP 400
        Given I set "GET" method for "accountDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100001 12345678@#& |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                                                 |
            | Response_error_type    | BusinessException                                                   |
            | Response_error_retry   | false                                                               |
            | Response_error_message | Invalid account id, check the contract specification for account id |

    @400  @error    @TestCaseKey=CAO-T645
    Scenario: Call Get Account Details service with more than maximum length of account number>28: HTTP 400
        Given I set "GET" method for "accountDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100999 1234567899999999999999 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                                                 |
            | Response_error_type    | BusinessException                                                   |
            | Response_error_retry   | false                                                               |
            | Response_error_message | Invalid account id, check the contract specification for account id |

    @401   @error   @TestCaseKey=CAO-T646
    Scenario: Account Manager - Get Account Details service without the Authorisation token: HTTP 401
        Given I set "GET" method for "accountDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100044 12345678 |
        When I send the request
        Then I verify the response status code as "401"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 401                              |
            | Response_error_type    | SystemException                  |
            | Response_error_retry   | false                            |
            | Response_error_message | Bad request check request header |

    @400   @error   @TestCaseKey=CAO-T647
    Scenario: Account Manager - Get Account Details service with incorrect Authorisation token: HTTP 400
        Given I set "GET" method for "accountDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100044 12345678 |
        And I "update" the following global values
            | jwt | hfysdgfsd |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                                                                           |
            | Response_error_type    | BusinessException                                                                             |
            | Response_error_retry   | false                                                                                         |
            | Response_error_message | Bad request check request header / Validation Error - Error while parsing authorization token |