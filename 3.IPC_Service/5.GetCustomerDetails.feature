@api @ipc   @regression
Feature: Scenarios for the IPC service Get customer details end point

    # *************************************************
    #              HAPPY PATH SCENARIOS
    # *************************************************

    # IPC Service - /ipcservice/api/v1/applications/{appId}/customer
    @happyPath  @TestCaseKey=CAO-T893
    Scenario: IPC Get customer details service and validate the response body: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1234567890"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I prepare the "CheckEligibility" payload details
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
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I save the response fields from "GetApplicant" in global data after "checkEligibility" to validate AppStore
        And I set "GET" method for "GetCustomerDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | {applicantId} |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        Then I send the request
        And I verify the response status code as "200"
        And I verify the complete response body should be "GetCustomerDetails"

    @happyPath  @TestCaseKey=CAO-T894
    Scenario: IPC Get customer details service for valid UK BFPO address with 3 address lines: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1411111113"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I prepare the "CheckEligibility" payload details
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
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I save the response fields from "GetApplicant" in global data after "checkEligibility" to validate AppStore
        And I set "GET" method for "GetCustomerDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | {applicantId} |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        Then I send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getCustomerDetails_serviceNoRankAndName | 1234123 Captain Pete |
            | Response_getCustomerDetails_unitRegiment         | Beta Unit            |
            | Response_getCustomerDetails_operationName        | Antarctica           |
            | Response_getCustomerDetails_bfpoNumber           | 3919                 |
            | Response_getCustomerDetails_isBfpoAddress        | true                 |
            | Response_getCustomerDetails_country              | GB                   |
        And I verify the following param value is "api_null" with response param value
            | Response_getCustomerDetails_buildingName      |  |
            | Response_getCustomerDetails_houseNameOrNumber |  |
            | Response_getCustomerDetails_area              |  |
            | Response_getCustomerDetails_addressLineOne    |  |
            | Response_getCustomerDetails_addressLineTwo    |  |
            | Response_getCustomerDetails_addressLineThree  |  |
            | Response_getCustomerDetails_postcode          |  |

    @happyPath  @TestCaseKey=CAO-T895
    Scenario: IPC Get customer details service for valid UK BFPO address with 2 address lines: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1411111112"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I prepare the "CheckEligibility" payload details
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
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I save the response fields from "GetApplicant" in global data after "checkEligibility" to validate AppStore
        And I set "GET" method for "GetCustomerDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | {applicantId} |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        Then I send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getCustomerDetails_serviceNoRankAndName | 1234123 Captain Pete |
            | Response_getCustomerDetails_unitRegiment         | Beta Unit Antarctica |
            | Response_getCustomerDetails_bfpoNumber           | 5489                 |
            | Response_getCustomerDetails_isBfpoAddress        | true                 |
            | Response_getCustomerDetails_country              | GB                   |
        And I verify the following param value is "api_null" with response param value
            | Response_getCustomerDetails_buildingName      |  |
            | Response_getCustomerDetails_houseNameOrNumber |  |
            | Response_getCustomerDetails_area              |  |
            | Response_getCustomerDetails_addressLineOne    |  |
            | Response_getCustomerDetails_addressLineTwo    |  |
            | Response_getCustomerDetails_addressLineThree  |  |
            | Response_getCustomerDetails_postcode          |  |
            | Response_getCustomerDetails_operationName     |  |

    @happyPath  @TestCaseKey=CAO-T896
    Scenario: IPC Get customer details service for Home address having buildingNumber value passed without buildingName: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111127"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I prepare the "CheckEligibility" payload details
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
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I save the response fields from "GetApplicant" in global data after "checkEligibility" to validate AppStore
        And I set "GET" method for "GetCustomerDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | {applicantId} |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        Then I send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getCustomerDetails_houseNameOrNumber | 404  |
            | Response_getCustomerDetails_addressLineOne    | Pond Street |
            | Response_getCustomerDetails_townOrCity        | SHEFFIELD   |
            | Response_getCustomerDetails_postcode          | S1 1AA      |
            | Response_getCustomerDetails_country           | GB          |
            | Response_getCustomerDetails_isBfpoAddress     | false       |
        And I verify the following param value is "api_null" with response param value
            | Response_getCustomerDetails_buildingName         |  |
            | Response_getCustomerDetails_area                 |  |
            | Response_getCustomerDetails_addressLineTwo       |  |
            | Response_getCustomerDetails_addressLineThree     |  |
            | Response_getCustomerDetails_serviceNoRankAndName |  |
            | Response_getCustomerDetails_unitRegiment         |  |
            | Response_getCustomerDetails_operationName        |  |
            | Response_getCustomerDetails_bfpoNumber           |  |

    @happyPath  @TestCaseKey=CAO-T897
    Scenario: IPC Get customer details service for Home address with Building Name and DependentLocality: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111139"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I prepare the "CheckEligibility" payload details
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
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I save the response fields from "GetApplicant" in global data after "checkEligibility" to validate AppStore
        And I set "GET" method for "GetCustomerDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | {applicantId} |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        Then I send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getCustomerDetails_buildingName   | Sheffield Delivery Office |
            | Response_getCustomerDetails_addressLineOne | Pond Street               |
            | Response_getCustomerDetails_area           | Southside                 |
            | Response_getCustomerDetails_townOrCity     | SHEFFIELD                 |
            | Response_getCustomerDetails_postcode       | S1 1AA                    |
            | Response_getCustomerDetails_country        | GB                        |
            | Response_getCustomerDetails_isBfpoAddress  | false                     |

    @happyPath  @TestCaseKey=CAO-T898
    Scenario: IPC Get customer details service for Home address with Building Name and Building Number: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111137"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I prepare the "CheckEligibility" payload details
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
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I save the response fields from "GetApplicant" in global data after "checkEligibility" to validate AppStore
        And I set "GET" method for "GetCustomerDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | {applicantId} |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        Then I send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getCustomerDetails_buildingName      | Sheffield Delivery Office |
            | Response_getCustomerDetails_houseNameOrNumber | 404                |
            | Response_getCustomerDetails_addressLineOne    | Pond Street               |
            | Response_getCustomerDetails_townOrCity        | SHEFFIELD                 |
            | Response_getCustomerDetails_postcode          | S1 1AA                    |
            | Response_getCustomerDetails_country           | GB                        |
            | Response_getCustomerDetails_isBfpoAddress     | false                     |

    @happyPath  @TestCaseKey=CAO-T899
    Scenario: IPC Get customer details service for Home address with Unit number and building number: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111138"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I prepare the "CheckEligibility" payload details
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
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I save the response fields from "GetApplicant" in global data after "checkEligibility" to validate AppStore
        And I set "GET" method for "GetCustomerDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | {applicantId} |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        Then I send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getCustomerDetails_buildingName      | Unit 6      |
            | Response_getCustomerDetails_houseNameOrNumber | 404  |
            | Response_getCustomerDetails_addressLineOne    | Pond Street |
            | Response_getCustomerDetails_townOrCity        | SHEFFIELD   |
            | Response_getCustomerDetails_postcode          | S1 1AA      |
            | Response_getCustomerDetails_country           | GB          |
            | Response_getCustomerDetails_isBfpoAddress     | false       |

    @happyPath  @TestCaseKey=CAO-T900
    Scenario: IPC Get customer details service for Home address with Unit Number, Building Name and DependentLocality: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111142"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I prepare the "CheckEligibility" payload details
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
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I save the response fields from "GetApplicant" in global data after "checkEligibility" to validate AppStore
        And I set "GET" method for "GetCustomerDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | {applicantId} |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        Then I send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getCustomerDetails_buildingName   | Unit 6, Sheffield Delivery Office |
            | Response_getCustomerDetails_addressLineOne | Pond Street                       |
            | Response_getCustomerDetails_area           | Southside                         |
            | Response_getCustomerDetails_townOrCity     | SHEFFIELD                         |
            | Response_getCustomerDetails_postcode       | S1 1AA                            |
            | Response_getCustomerDetails_country        | GB                                |
            | Response_getCustomerDetails_isBfpoAddress  | false                             |

    @happyPath  @TestCaseKey=CAO-T901
    Scenario: IPC Get customer details service for Home address with DependentThoroughfare and DependentLocality: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111140"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I prepare the "CheckEligibility" payload details
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
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I save the response fields from "GetApplicant" in global data after "checkEligibility" to validate AppStore
        And I set "GET" method for "GetCustomerDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | {applicantId} |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        Then I send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getCustomerDetails_houseNameOrNumber | 404  |
            | Response_getCustomerDetails_addressLineOne    | The Close    |
            | Response_getCustomerDetails_addressLineTwo    | Pond Street |
            | Response_getCustomerDetails_area              | Southside   |
            | Response_getCustomerDetails_townOrCity        | SHEFFIELD   |
            | Response_getCustomerDetails_postcode          | S1 1AA      |
            | Response_getCustomerDetails_country           | GB          |
            | Response_getCustomerDetails_isBfpoAddress     | false       |

    # *************************************************
    #             ######## ERROR SCENARIOS #########
    # *************************************************
    # ****************************************************************************
    #    Field Level Validation for Headers
    # ****************************************************************************

    @error  @400    @TestCaseKey=CAO-T858
    Scenario: IPC Get customer details service when journey id is not provided in the header: HTTP 400
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1234567890"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I prepare the "CheckEligibility" payload details
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
        And I set "GET" method for "GetCustomerDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | {applicantId} |
        And I set the headers for the request
            | Authorization |  |
        Then I send the request
        And I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                             |
            | Response_error_type    | BusinessException               |
            | Response_error_retry   | false                           |
            | Response_error_message | Missing x-journey-id in request |

    @error  @400    @TestCaseKey=CAO-T902
    Scenario: IPC Get customer details service when invalid journey id is provided in the header: HTTP 400
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1234567890"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I prepare the "CheckEligibility" payload details
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
        And I set "GET" method for "GetCustomerDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | {applicantId} |
        And I "update" the following global values
            | x-journey-id | 111111 |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        Then I send the request
        And I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                    |
            | Response_error_type    | BusinessException                      |
            | Response_error_retry   | false                                  |
            | Response_error_message | Valid x-journey-id required in request |

    @error  @401    @TestCaseKey=CAO-T903
    Scenario: IPC Get customer details service when Authorization is not provided in the header: HTTP 401
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1234567890"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I prepare the "CheckEligibility" payload details
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
        And I set "GET" method for "GetCustomerDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | {applicantId} |
        And I set the headers for the request
            | x-journey-Id |  |
        Then I send the request
        And I verify the response status code as "401"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 401                                                   |
            | Response_error_type    | BusinessException                                     |
            | Response_error_retry   | false                                                 |
            | Response_error_message | Authorization is not available or can not be verified |

    @error  @401    @TestCaseKey=CAO-T904
    Scenario: IPC Get customer details service when invalid Authorization is provided in the header: HTTP 401
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1234567890"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I prepare the "CheckEligibility" payload details
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
        And I set "GET" method for "GetCustomerDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | {applicantId} |
        And I "update" the following global values
            | jwt | 111111 |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        Then I send the request
        And I verify the response status code as "401"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 401                                                   |
            | Response_error_type    | BusinessException                                     |
            | Response_error_retry   | false                                                 |
            | Response_error_message | Authorization is not available or can not be verified |

    # ****************************************************************************
    #    Field Level Validation for Query/Path Parameters
    # ****************************************************************************

    @error  @400    @TestCaseKey=CAO-T905
    Scenario: IPC Get customer details service when Applicant Id is not provided in the query parameter: HTTP 400
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1234567890"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I prepare the "CheckEligibility" payload details
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
        And I set "GET" method for "GetCustomerDetails"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        Then I send the request
        And I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                            |
            | Response_error_type    | BusinessException              |
            | Response_error_retry   | false                          |
            | Response_error_message | Missing ApplicantId in request |

    @error  @400    @TestCaseKey=CAO-T929
    Scenario: IPC Get customer details service when invalid Applicant Id is provided in the query parameter: HTTP 400
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1234567890"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I prepare the "CheckEligibility" payload details
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
        And I set "GET" method for "GetCustomerDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | 1111 |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        Then I send the request
        And I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                   |
            | Response_error_type    | BusinessException                     |
            | Response_error_retry   | false                                 |
            | Response_error_message | Valid ApplicantId required in request |

    @error  @400    @TestCaseKey=CAO-T906
    Scenario: IPC Get customer details service when invalid App Id is provided in the path parameter: HTTP 400
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1234567890"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I prepare the "CheckEligibility" payload details
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
        And I set "GET" method for "GetCustomerDetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | 1111 |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        Then I send the request
        And I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                             |
            | Response_error_type    | BusinessException               |
            | Response_error_retry   | false                           |
            | Response_error_message | Valid AppId required in request |