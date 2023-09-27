@api @regression @ipc
Feature: Scenarios for the IPC service Get Product data end point

    # *************************************************
    #              HAPPY PATH SCENARIOS
    # *************************************************

    # IPC Service - /ipcservice/api/v1/applications/{appId}/product
    @happyPath  @TestCaseKey=CAO-T907
    Scenario: IPC Get Product data service and validate the response body when account number is not passed from IB/BA: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111119"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I set "GET" method for "IPC_AccountList"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | originalProductType | 7002                  |
            | applicationRevision | {applicationRevision} |
        And I set the headers for the request
            | authorization |           |
            | x-journey-id |  |
        Then I send the request
        And I verify the response status code as "200"
        Given I prepare the "CheckEligibility" payload details
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I set "GET" method for "GetProductData"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the complete response body should be "GetProductData"

    @happyPath  @TestCaseKey=CAO-T1058
    Scenario: IPC Get Product data service and validate the response body when account number is passed from IB/BA: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111119"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number "123456 12345678" and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I set "GET" method for "GetProductData"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the complete response body should be "GetProductData"

    # *************************************************
    #             ERROR SCENARIOS
    # *************************************************

    @error  @400    @TestCaseKey=CAO-T935
    Scenario: IPC Get Product Data service when journey id is not provided in the header: HTTP 400
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111119"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number "123456 12345678" and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I set "GET" method for "GetProductData"
        And I set the config for the request to "default"
        And I set the headers for the request
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                             |
            | Response_error_type    | BusinessException               |
            | Response_error_retry   | false                           |
            | Response_error_message | Missing x-journey-id in request |

    @error  @400    @TestCaseKey=CAO-T936
    Scenario: IPC Get Product Data service when invalid journey id is provided in the header: HTTP 400
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111119"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number "123456 12345678" and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I set "GET" method for "GetProductData"
        And I set the config for the request to "default"
        And I "update" the following global values
            | x-journey-id | 111111 |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                    |
            | Response_error_type    | BusinessException                      |
            | Response_error_retry   | false                                  |
            | Response_error_message | Valid x-journey-id required in request |

    @error  @401    @TestCaseKey=CAO-T939
    Scenario: IPC Get Product Data service when Authorization is not provided in the header: HTTP 401
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111119"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number "123456 12345678" and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I set "GET" method for "GetProductData"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id |  |
        When I send the request
        Then I verify the response status code as "401"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 401                                                   |
            | Response_error_type    | BusinessException                                     |
            | Response_error_retry   | false                                                 |
            | Response_error_message | Authorization is not available or can not be verified |

    @error  @401    @TestCaseKey=CAO-T940
    Scenario: IPC Get Product Data service when invalid Authorization is provided in the header: HTTP 401
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111119"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number "123456 12345678" and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I set "GET" method for "GetProductData"
        And I set the config for the request to "default"
        And I "update" the following global values
            | jwt | 111111 |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "401"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 401                                                   |
            | Response_error_type    | BusinessException                                     |
            | Response_error_retry   | false                                                 |
            | Response_error_message | Authorization is not available or can not be verified |

    # ****************************************************************************
    #    Field Level Validation for Path Parameters
    # ****************************************************************************

    @error  @400    @TestCaseKey=CAO-T943
    Scenario: IPC Get Product Data service when invalid App Id is provided in the path parameter: HTTP 400
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111119"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number "123456 12345678" and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I "update" the following global values
            | appId | 111111 |
        And I set "GET" method for "GetProductData"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                             |
            | Response_error_type    | BusinessException               |
            | Response_error_retry   | false                           |
            | Response_error_message | Valid AppId required in request |
