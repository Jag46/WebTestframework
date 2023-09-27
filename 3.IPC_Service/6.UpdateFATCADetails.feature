@api @regression @ipc
Feature: Scenarios for the IPC service Update customer FATCA details end point

    Background: Calling IPC check eligibility endpoint
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111119"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I prepare the "CheckEligibility" payload details
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
    
    # *************************************************
    #              HAPPY PATH SCENARIOS
    # *************************************************

    # IPC Service - /ipcservice/api/v1/applications/{appId}/customer/fatca

    @happyPath  @TestCaseKey=CAO-T983 @defect-12985
    Scenario: IPC service to update customer FATCA details when isLiableToPayTaxInAnotherCountry is false: HTTP 200
        Given I set the "Updatefatcadetails" request body
        And I set "PUT" method for "IPC_FATCADetails"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision | global | Request_updateFatcaDetails_applicantRevision |
            | applicantId       | global | Request_updateFatcaDetails_applicantId       |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_serviceStatusCode | 200                                 |
            | Response_getApplicationStatus_statusRetry       | false                               |
            | Response_getApplicationStatus_statusType        | Success                             |
            | Response_getApplicationStatus_statusMessage     | Resource saved/fetched successfully |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_nationalityAndTax_applicantId                      | {applicantId} |
            | RAS_nationalityAndTax_isLiableToPayTaxInAnotherCountry | false         |
            | RAS_nationalityAndTax_isNonUkResidentForTaxPurposes    | false         |
            | RAS_nationalityAndTax_isUkResident                     | false          |
            | RAS_nationalityAndTax_isUsCitizen                      | false         |
            | RAS_nationalityAndTax_tinNumber1                       |               |
            | RAS_nationalityAndTax_country1                         |               |
            | RAS_nationalityAndTax_isDualNational                   | false         |

    @happyPath  @TestCaseKey=CAO-T984
    Scenario: IPC service to update customer FATCA details when isLiableToPayTaxInAnotherCountry is true and USCitizen is false: HTTP 200
        Given I set the "Updatefatcadetails" request body
        And I set "PUT" method for "IPC_FATCADetails"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision                | global     | Request_updateFatcaDetails_applicantRevision                |
            | applicantId                      | global     | Request_updateFatcaDetails_applicantId                      |
            | isLiableToPayTaxInAnotherCountry | true       | Request_updateFatcaDetails_isLiableToPayTaxInAnotherCountry |
            | isUsCitizen                      | false      | Request_updateFatcaDetails_isUsCitizen                      |
            | isNonUkResidentForTaxPurposes    | true       | Request_updateFatcaDetails_isNonUkResidentForTaxPurposes    |
            | isUkResident                     | true       | Request_updateFatcaDetails_isUkResident                     |
            | tinNumber                        | A312DJEJFW | Request_updateFatcaDetails_tinNumber1                       |
            | country                          | IN         | Request_updateFatcaDetails_country1                         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_serviceStatusCode | 200                                 |
            | Response_getApplicationStatus_statusRetry       | false                               |
            | Response_getApplicationStatus_statusType        | Success                             |
            | Response_getApplicationStatus_statusMessage     | Resource saved/fetched successfully |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_nationalityAndTax_applicantId                      | {applicantId} |
            | RAS_nationalityAndTax_isLiableToPayTaxInAnotherCountry | true          |
            | RAS_nationalityAndTax_isNonUkResidentForTaxPurposes    | true          |
            | RAS_nationalityAndTax_isUkResident                     | true          |
            | RAS_nationalityAndTax_isUsCitizen                      | false         |
            | RAS_nationalityAndTax_tinNumber1                       | A312DJEJFW    |
            | RAS_nationalityAndTax_country1                         | IN            |
            | RAS_nationalityAndTax_isDualNational                   | false         |

    @happyPath  @TestCaseKey=CAO-T985
    Scenario: IPC service to update customer FATCA details when when isLiableToPayTaxInAnotherCountry is true and USCitizen is true: HTTP 200
        Given I set the "Updatefatcadetails" request body
        And I set "PUT" method for "IPC_FATCADetails"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision                | global     | Request_updateFatcaDetails_applicantRevision                |
            | applicantId                      | global     | Request_updateFatcaDetails_applicantId                      |
            | isLiableToPayTaxInAnotherCountry | true       | Request_updateFatcaDetails_isLiableToPayTaxInAnotherCountry |
            | isUsCitizen                      | true       | Request_updateFatcaDetails_isUsCitizen                      |
            | isNonUkResidentForTaxPurposes    | false      | Request_updateFatcaDetails_isNonUkResidentForTaxPurposes    |
            | isUkResident                     | true       | Request_updateFatcaDetails_isUkResident                     |
            | tinNumber                        | A312DJEJFW | Request_updateFatcaDetails_tinNumber1                       |
            | country                          | US         | Request_updateFatcaDetails_country1                         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_serviceStatusCode | 200                                 |
            | Response_getApplicationStatus_statusRetry       | false                               |
            | Response_getApplicationStatus_statusType        | Success                             |
            | Response_getApplicationStatus_statusMessage     | Resource saved/fetched successfully |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_nationalityAndTax_applicantId                      | {applicantId} |
            | RAS_nationalityAndTax_isLiableToPayTaxInAnotherCountry | true          |
            | RAS_nationalityAndTax_isNonUkResidentForTaxPurposes    | false         |
            | RAS_nationalityAndTax_isUkResident                     | true          |
            | RAS_nationalityAndTax_isUsCitizen                      | true          |
            | RAS_nationalityAndTax_tinNumber1                       | A312DJEJFW    |
            | RAS_nationalityAndTax_country1                         | US            |
            | RAS_nationalityAndTax_isDualNational                   | false         |

    @happyPath  @TestCaseKey=CAO-T986
    Scenario: IPC service to update customer FATCA details when isNonUkResidentForTaxPurposes is true with 2 countries Tax payee: HTTP 200
        Given I set the "Updatefatcadetails" request body
        And I set "PUT" method for "IPC_FATCADetails"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision                | global     | Request_updateFatcaDetails_applicantRevision                |
            | applicantId                      | global     | Request_updateFatcaDetails_applicantId                      |
            | isLiableToPayTaxInAnotherCountry | true       | Request_updateFatcaDetails_isLiableToPayTaxInAnotherCountry |
            | isUsCitizen                      | false      | Request_updateFatcaDetails_isUsCitizen                      |
            | isNonUkResidentForTaxPurposes    | true       | Request_updateFatcaDetails_isNonUkResidentForTaxPurposes    |
            | isUkResident                     | true       | Request_updateFatcaDetails_isUkResident                     |
            | tinNumber                        | A312DJEJFW | Request_updateFatcaDetails_tinNumber1                       |
            | country                          | IN         | Request_updateFatcaDetails_country1                         |
            | tinNumber                        | A312DJE5FW | Request_updateFatcaDetails_tinNumber2                       |
            | country                          | AX         | Request_updateFatcaDetails_country2                         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_serviceStatusCode | 200                                 |
            | Response_getApplicationStatus_statusRetry       | false                               |
            | Response_getApplicationStatus_statusType        | Success                             |
            | Response_getApplicationStatus_statusMessage     | Resource saved/fetched successfully |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_nationalityAndTax_applicantId                      | {applicantId} |
            | RAS_nationalityAndTax_isLiableToPayTaxInAnotherCountry | true          |
            | RAS_nationalityAndTax_isNonUkResidentForTaxPurposes    | true          |
            | RAS_nationalityAndTax_isUkResident                     | true          |
            | RAS_nationalityAndTax_isUsCitizen                      | false         |
            | RAS_nationalityAndTax_tinNumber1                       | A312DJEJFW    |
            | RAS_nationalityAndTax_country1                         | IN            |
            | RAS_nationalityAndTax_tinNumber2                       | A312DJE5FW    |
            | RAS_nationalityAndTax_country2                         | AX            |
            | RAS_nationalityAndTax_isDualNational                   | false         |

    @happyPath  @TestCaseKey=CAO-T987
    Scenario: IPC service to update customer FATCA details when isNonUkResidentForTaxPurposes is true with 3 countries Tax payee: HTTP 200
        Given I set the "Updatefatcadetails" request body
        And I set "PUT" method for "IPC_FATCADetails"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision                | global     | Request_updateFatcaDetails_applicantRevision                |
            | applicantId                      | global     | Request_updateFatcaDetails_applicantId                      |
            | isLiableToPayTaxInAnotherCountry | true       | Request_updateFatcaDetails_isLiableToPayTaxInAnotherCountry |
            | isUsCitizen                      | false      | Request_updateFatcaDetails_isUsCitizen                      |
            | isNonUkResidentForTaxPurposes    | true       | Request_updateFatcaDetails_isNonUkResidentForTaxPurposes    |
            | isUkResident                     | true       | Request_updateFatcaDetails_isUkResident                     |
            | tinNumber                        | A312DJEJFW | Request_updateFatcaDetails_tinNumber1                       |
            | country                          | IN         | Request_updateFatcaDetails_country1                         |
            | tinNumber                        | A312DJE5FW | Request_updateFatcaDetails_tinNumber2                       |
            | country                          | AX         | Request_updateFatcaDetails_country2                         |
            | tinNumber                        | A312DJE7FW | Request_updateFatcaDetails_tinNumber3                       |
            | country                          | AE         | Request_updateFatcaDetails_country3                         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_serviceStatusCode | 200                                 |
            | Response_getApplicationStatus_statusRetry       | false                               |
            | Response_getApplicationStatus_statusType        | Success                             |
            | Response_getApplicationStatus_statusMessage     | Resource saved/fetched successfully |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_nationalityAndTax_applicantId                      | {applicantId} |
            | RAS_nationalityAndTax_isLiableToPayTaxInAnotherCountry | true          |
            | RAS_nationalityAndTax_isNonUkResidentForTaxPurposes    | true          |
            | RAS_nationalityAndTax_isUkResident                     | true          |
            | RAS_nationalityAndTax_isUsCitizen                      | false         |
            | RAS_nationalityAndTax_tinNumber1                       | A312DJEJFW    |
            | RAS_nationalityAndTax_country1                         | IN            |
            | RAS_nationalityAndTax_tinNumber2                       | A312DJE5FW    |
            | RAS_nationalityAndTax_country2                         | AX            |
            | RAS_nationalityAndTax_tinNumber3                       | A312DJE7FW    |
            | RAS_nationalityAndTax_country3                         | AE            |
            | RAS_nationalityAndTax_isDualNational                   | false         |

    # # *************************************************
    # #             ERROR SCENARIOS
    # # *************************************************

    @error @400 @TestCaseKey=CAO-T988
    Scenario: IPC Update customer FATCA details service when the app id is invalid:HTTP 400
        Given I "update" the following global values
            | appId | hfysdgfsd |
        And I set the "Updatefatcadetails" request body
        And I set "PUT" method for "IPC_FATCADetails"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision | global | Request_updateFatcaDetails_applicantRevision |
            | applicantId       | global | Request_updateFatcaDetails_applicantId       |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_serviceStatusCode | 400                             |
            | Response_getApplicationStatus_statusRetry       | false                           |
            | Response_getApplicationStatus_statusType        | BusinessException               |
            | Response_getApplicationStatus_statusMessage     | Valid AppId required in request |

    @error @400 @TestCaseKey=CAO-T989
    Scenario: IPC Update customer FATCA details service when the x-journey-id is invalid:HTTP 400
        Given I set the "Updatefatcadetails" request body
        And I set "PUT" method for "IPC_FATCADetails"
        And I set the config for the request to "default"
        And I "update" the following global values
            | x-journey-id | 111111 |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision | global | Request_updateFatcaDetails_applicantRevision |
            | applicantId       | global | Request_updateFatcaDetails_applicantId       |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_serviceStatusCode | 400                                    |
            | Response_getApplicationStatus_statusRetry       | false                                  |
            | Response_getApplicationStatus_statusType        | BusinessException                      |
            | Response_getApplicationStatus_statusMessage     | Valid x-journey-id required in request |

    @error @400 @TestCaseKey=CAO-T990
    Scenario: IPC Update customer FATCA details service when the x-journey-id is missing:HTTP 400
        Given I set the "Updatefatcadetails" request body
        And I set "PUT" method for "IPC_FATCADetails"
        And I set the config for the request to "default"
        And I "update" the following global values
            | journeyId | 111111 |
        And I set the headers for the request
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision | global | Request_updateFatcaDetails_applicantRevision |
            | applicantId       | global | Request_updateFatcaDetails_applicantId       |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_serviceStatusCode | 400                             |
            | Response_getApplicationStatus_statusRetry       | false                           |
            | Response_getApplicationStatus_statusType        | BusinessException               |
            | Response_getApplicationStatus_statusMessage     | Missing x-journey-id in request |

    @error @401 @TestCaseKey=CAO-T991
    Scenario: IPC Update customer FATCA details service when the Authorization token is invalid:HTTP 401
        Given I set the "Updatefatcadetails" request body
        And I set "PUT" method for "IPC_FATCADetails"
        And I set the config for the request to "default"
        And I "update" the following global values
            | jwt | hfysdgfsd |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision | global | Request_updateFatcaDetails_applicantRevision |
            | applicantId       | global | Request_updateFatcaDetails_applicantId       |
        When I send the request
        Then I verify the response status code as "401"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_serviceStatusCode | 401                                                   |
            | Response_getApplicationStatus_statusRetry       | false                                                 |
            | Response_getApplicationStatus_statusType        | BusinessException                                     |
            | Response_getApplicationStatus_statusMessage     | Authorization is not available or can not be verified |

    @error @401 @TestCaseKey=CAO-T992
    Scenario: IPC Update customer FATCA details service when the Authorization token is missing:HTTP 401
        Given I set the "Updatefatcadetails" request body
        And I set "PUT" method for "IPC_FATCADetails"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id |  |
        And I modify the following param values in the current request body
            | applicantRevision | global | Request_updateFatcaDetails_applicantRevision |
            | applicantId       | global | Request_updateFatcaDetails_applicantId       |
        When I send the request
        Then I verify the response status code as "401"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_serviceStatusCode | 401                                                   |
            | Response_getApplicationStatus_statusRetry       | false                                                 |
            | Response_getApplicationStatus_statusType        | BusinessException                                     |
            | Response_getApplicationStatus_statusMessage     | Authorization is not available or can not be verified |