@api @regression @ipc
Feature: Scenarios for the IPC service Get Account List service call

    # *************************************************
    #              HAPPY PATH SCENARIOS
    # *************************************************

    # IPC Service - /ipcservice/api/v1/applications/{appId}/accountlist

    @happyPath  @TestCaseKey=CAO-T587
    Scenario: Call Get Account List service for a customer where No accounts are returned: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111118"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002                  |
            | applicationRevision | {applicationRevision} |
        And I set the headers for the request
            | Authorization |           |
            | x-journey-id | 132132123 |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the number of "responsePayload.accounts" returned are "equals" to "0"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the number of "responsePayload.existingProducts" returned are "equals" to "0"

    @happyPath  @TestCaseKey=CAO-T588
    Scenario: Call Get Account List service for a customer which has no active accounts ie. accountLifecycleStatus = 0 for all the accounts: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "2011111111"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002                  |
            | applicationRevision | {applicationRevision} |
        And I set the headers for the request
            | Authorization |           |
            | x-journey-id | 132132123 |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the number of "responsePayload.accounts" returned are "equals" to "0"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the number of "responsePayload.existingProducts" returned are "equals" to "0"

    @happyPath  @TestCaseKey=CAO-T589
    Scenario: Call Get Account List service for a Customer who has active account and ownerNoTraceIndicator value is true : HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "2021111111"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002                  |
            | applicationRevision | {applicationRevision} |
        And I set the headers for the request
            | Authorization |           |
            | x-journey-id | 132132123 |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the number of "responsePayload.accounts" returned are "equals" to "1"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the number of "responsePayload.existingProducts" returned are "equals" to "1"

    @happyPath  @TestCaseKey=CAO-T590
    Scenario: Call Get Account List service for a Customer with Available balance exceeds the allowed overdraft limit : HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "2031111111"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002                  |
            | applicationRevision | {applicationRevision} |
        And I set the headers for the request
            | Authorization |           |
            | x-journey-id | 132132123 |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the number of "responsePayload.accounts" returned are "equals" to "0"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the number of "responsePayload.existingProducts" returned are "equals" to "0"
            
    @happyPath  @TestCaseKey=CAO-T591
    Scenario: Call Get Account List service for a customer with Partial Success for CAB, empty productName and 207 status: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "2061111111"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002                  |
            | applicationRevision | {applicationRevision} |
        And I set the headers for the request
            | Authorization |           |
            | x-journey-id | 132132123 |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the number of "responsePayload.accounts" returned are "equals" to "1"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the number of "responsePayload.existingProducts" returned are "equals" to "1"

    @happyPath  @TestCaseKey=CAO-T592
    Scenario: Call Get Account List service for a customer which Returns list of valid accounts that meet the scenarios for RAD and SAP account locks: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111119"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002                  |
            | applicationRevision | {applicationRevision} |
        And I set the headers for the request
            | Authorization |           |
            | x-journey-id | 132132123 |
        When I send the request
        Then I verify the response status code as "200"
        Then I verify the number of "responsePayload.accounts" returned are "equals" to "49"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        Then I verify the number of "responsePayload.existingProducts" returned are "equals" to "49"

    @happyPath  @TestCaseKey=CAO-T593
    Scenario: Call Get Account List service for a customer with multiple active flex accounts: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111120"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002                  |
            | applicationRevision | {applicationRevision} |
        And I set the headers for the request
            | Authorization |           |
            | x-journey-id | 132132123 |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the number of "responsePayload.accounts" returned are "equals" to "3"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the number of "responsePayload.existingProducts" returned are "equals" to "3"

    @happyPath  @TestCaseKey=CAO-T594
    Scenario: Call Get Account List service for a customer with active & inactive flex accounts & ensure only active flex accounts are returned: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111121"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002                  |
            | applicationRevision | {applicationRevision} |
        And I set the headers for the request
            | x-journey-id | 132132123 |
            | Authorization |           |
        When I send the request
        Then I verify the response status code as "200"
        Then I verify the number of "responsePayload.accounts" returned are "equals" to "1"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the number of "responsePayload.existingProducts" returned are "equals" to "1"

    @happyPath  @TestCaseKey=CAO-T595
    Scenario: Call Get Account List service for a customer who Returns list of multiple different account types (not including flex direct): HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111122"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002                  |
            | applicationRevision | {applicationRevision} |
        And I set the headers for the request
            | x-journey-id | 132132123 |
            | Authorization |           |
        When I send the request
        Then I verify the response status code as "200"
        Then I verify the number of "responsePayload.accounts" returned are "equals" to "2"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the number of "responsePayload.existingProducts" returned are "equals" to "2"

    @happyPath  @TestCaseKey=CAO-T596
    Scenario: Call Get Account List service for a customer with multiple types of active accounts including active Flex Direct: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111123"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002                  |
            | applicationRevision | {applicationRevision} |
        And I set the headers for the request
            | x-journey-id | 132132123 |
            | Authorization |           |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the number of "responsePayload.accounts" returned are "equals" to "2"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the number of "responsePayload.existingProducts" returned are "equals" to "2"

    @happyPath  @TestCaseKey=CAO-T597
    Scenario: Call Get Account List service for a customer with multiple different account types (including inactive flex direct): HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111124"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002                  |
            | applicationRevision | {applicationRevision} |
        And I set the headers for the request
            | x-journey-id | 132132123 |
            | Authorization |           |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the number of "responsePayload.accounts" returned are "equals" to "2"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the number of "responsePayload.existingProducts" returned are "equals" to "2"

    @happyPath  @TestCaseKey=CAO-T598
    Scenario: Call Get Account List service for a customer to call the default scenario from CABS stub: A single account with cPUsage sent: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "123"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002                  |
            | applicationRevision | {applicationRevision} |
        And I set the headers for the request
            | x-journey-id | 132132123 |
            | Authorization |           |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the number of "responsePayload.accounts" returned are "equals" to "1"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the number of "responsePayload.existingProducts" returned are "equals" to "1"

    # *************************************************
    #             ERROR SCENARIOS
    # *************************************************

    @error  @500    @TestCaseKey=CAO-T599
    Scenario: Call Get Account List service for a Customer who has OwnerNoTrace Indicator value is null : HTTP 500
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "2041111111"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002                  |
            | applicationRevision | {applicationRevision} |
        And I set the headers for the request
            | Authorization |           |
            | x-journey-id | 132132123 |
        When I send the request
        Then I verify the response status code as "500"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 500                                                               |
            | Response_error_type    | BusinessException                                                 |
            | Response_error_retry   | false                                                             |
            | Response_error_message | Unhandled exception -  Value cannot be null. (Parameter 'source') |

    @error   @500   @TestCaseKey=CAO-T600
    Scenario: Call Get Account List service for a Customer who has OwnerNoTrace Indicator value is empty : HTTP 500
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "2051111111"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002                  |
            | applicationRevision | {applicationRevision} |
        And I set the headers for the request
            | Authorization |           |
            | x-journey-id | 132132123 |
        When I send the request
        Then I verify the response status code as "500"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 500                                                               |
            | Response_error_type    | BusinessException                                                 |
            | Response_error_retry   | false                                                             |
            | Response_error_message | Unhandled exception -  Value cannot be null. (Parameter 'source') |

    @error @500 @TestCaseKey=CAO-T601
    Scenario: Call IPC Get Account List service when CABS NEM service returns 500 Error:HTTP 500
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111110500"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002                  |
            | applicationRevision | {applicationRevision} |
        And I set the headers for the request
            | x-journey-id | 132132123 |
            | Authorization |           |
        When I send the request
        Then I verify the response status code as "500"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 500                                                               |
            | Response_error_type    | BusinessException                                                 |
            | Response_error_retry   | false                                                             |
            | Response_error_message | Unhandled exception -  Value cannot be null. (Parameter 'source') |

    @error @500 @TestCaseKey=CAO-T602
    Scenario: Call IPC Get Account List service when CABS NEM service returns 400 Error:HTTP 500
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111110400"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002                  |
            | applicationRevision | {applicationRevision} |
        And I set the headers for the request
            | x-journey-id | 132132123 |
            | Authorization |           |
        When I send the request
        Then I verify the response status code as "500"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 500                                                               |
            | Response_error_type    | BusinessException                                                 |
            | Response_error_retry   | false                                                             |
            | Response_error_message | Unhandled exception -  Value cannot be null. (Parameter 'source') |

    @error  @401    @TestCaseKey=CAO-T603
    Scenario: IPC Get Account List service when invalid authorisation token is provided:HTTP 401
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111120"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I "update" the following global values
            | jwt | hfysdgfsd |
        And I set the query parameters for the request
            | originalProductType | 7002                  |
            | applicationRevision | {applicationRevision} |
        And I set the headers for the request
            | x-journey-id |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "401"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 401                                               |
            | Response_error_type    | BusinessException                                 |
            | Response_error_retry   | false                                             |
            | Response_error_message | Authorization is not available or can not be verified |

    @error  @401    @TestCaseKey=CAO-T604
    Scenario: IPC Get Account List service when authorisation token is not provided:HTTP 401
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111122"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002                  |
            | applicationRevision | {applicationRevision} |
        And I set the headers for the request
            | x-journey-id |  |
        When I send the request
        Then I verify the response status code as "401"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 401                                               |
            | Response_error_type    | BusinessException                                 |
            | Response_error_retry   | false                                             |
            | Response_error_message | Authorization is not available or can not be verified |

    @error @400 @TestCaseKey=CAO-T605
    Scenario: Call IPC Get Account List service when the original Product Id is not passed:HTTP 400
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111122"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicationRevision | {applicationRevision} |
        And I set the headers for the request
            | x-journey-id |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                  |
            | Response_error_type    | BusinessException                    |
            | Response_error_retry   | false                                |
            | Response_error_message | Missing OriginalProductID in request |

    @error @400 @TestCaseKey=CAO-T851
    Scenario: Call IPC Get Account List service when the original Product Id is Invalid:HTTP 400
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111122"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002ert               |
            | applicationRevision | {applicationRevision} |
        And I set the headers for the request
            | x-journey-id |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                         |
            | Response_error_type    | BusinessException                           |
            | Response_error_retry   | false                                       |
            | Response_error_message | Valid OriginalProductID required in request |

    @error @400 @TestCaseKey=CAO-T852
    Scenario: Call IPC Get Account List service when the ApplicationRevision is not provided:HTTP 400
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111122"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002 |
        And I set the headers for the request
            | x-journey-id | 12345er |
            | Authorization |         |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                    |
            | Response_error_type    | BusinessException                      |
            | Response_error_retry   | false                                  |
            | Response_error_message | Missing ApplicationRevision in request |

    @error @500 @TestCaseKey=CAO-T853
    Scenario: Call IPC Get Account List service when a non existing ApplicationRevision is provided:HTTP 500
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111122"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002                                 |
            | applicationRevision | 1028192d-c913-45dc-aabe |
        And I set the headers for the request
            | x-journey-id |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                           |
            | Response_error_type    | BusinessException                             |
            | Response_error_retry   | false                                         |
            | Response_error_message | Valid ApplicationRevision required in request |

    @error @400 @TestCaseKey=CAO-T854
    Scenario: Call IPC Get Account List service when the ApplicationRevision is Invalid format:HTTP 400
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111122"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002                                      |
            | applicationRevision | 1028192d-c913-45dc-aabe-1adbbf64c732456ty |
        And I set the headers for the request
            | x-journey-id |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                           |
            | Response_error_type    | BusinessException                             |
            | Response_error_retry   | false                                         |
            | Response_error_message | Valid ApplicationRevision required in request |

    @error @400 @TestCaseKey=CAO-T855
    Scenario: Call IPC Get Account List service when the x-journey-id is Invalid:HTTP 400
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111122"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002                  |
            | applicationRevision | {applicationRevision} |
        And I "update" the following global values
            | x-journey-id | hfysdgfsd |
        And I set the headers for the request
            | x-journey-id |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                    |
            | Response_error_type    | BusinessException                      |
            | Response_error_retry   | false                                  |
            | Response_error_message | Valid x-journey-id required in request |

    @error @400 @TestCaseKey=CAO-T856
    Scenario: Call IPC Get Account List service when the x-journey-id is not provided:HTTP 400
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111122"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002                  |
            | applicationRevision | {applicationRevision} |
        And I set the headers for the request
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                             |
            | Response_error_type    | BusinessException               |
            | Response_error_retry   | false                           |
            | Response_error_message | Missing x-journey-id in request |

    @error @400 @TestCaseKey=CAO-T857
    Scenario: Call IPC Get Account List service when the AppId is Invalid:HTTP 400
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111122"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I set the path paramters for a request
            | appId | 1234 |
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I "update" the following global values
            | appId | 234567833 |
        And I set the query parameters for the request
            | originalProductType | 7002                  |
            | applicationRevision | {applicationRevision} |
        And I set the headers for the request
            | x-journey-id |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                             |
            | Response_error_type    | BusinessException               |
            | Response_error_retry   | false                           |
            | Response_error_message | Valid AppId required in request |