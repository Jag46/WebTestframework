@api @regression @ipc
Feature: Scenarios for the IPC service Get application status after eligibility end point

    # *************************************************
    #              HAPPY PATH SCENARIOS
    # *************************************************

    # IPC Service - /ipcservice/api/v1/applications/{appId}/status
    
    @happyPath @TestCaseKey=CAO-T957
    Scenario: IPC service Get application status for eligibility check passed and existingTaxDeclarationStatus is Y: HTTP 200
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
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_existingTaxDeclarationStatus | Y          |
            | Response_getApplicationStatus_statusCode                   | InProgress |
            | Response_getApplicationStatus_agreedOverdraftLimit         | 100.00     |
            | Response_getApplicationStatus_isEligibleForAccount         | true       |
            | Response_getApplicationStatus_sortCode                     | 123456     |
            | Response_getApplicationStatus_accountNumber                | 12345678   |
            | Response_getApplicationStatus_serviceStatusCode            | 0          |
            | Response_getApplicationStatus_statusRetry                  | false      |
            | Response_getApplicationStatus_statusType                   | Success    |
            | Response_getApplicationStatus_statusMessage                | Success    |
    
    @happyPath @TestCaseKey=CAO-T958
    Scenario: IPC service Get application status for Account without the overdraft limit and overdrawn balance: HTTP 200
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
            | accountNumber       | 10000008 | Request_eligibility_accountNo           |
            | applicantRevision   | global   | Request_eligibility_applicantRevision   |
            | applicationRevision | global   | Request_eligibility_applicationRevision |
            | applicantId         | global   | Request_eligibility_applicantId         |
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_statusCode           | Terminated                                             |
            | Response_getApplicationStatus_isEligibleForAccount | false                                                  |
            | Response_getApplicationStatus_errorCode            | 210                                                    |
            | Response_getApplicationStatus_errorMessage         | Account is overdrawn beyond the agreed overdraft limit |

    @happyPath @TestCaseKey=CAO-T959
    Scenario: IPC service Get application status for Account with zero overdraft limit: HTTP 200
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
            | accountNumber       | 10000009 | Request_eligibility_accountNo           |
            | applicantRevision   | global   | Request_eligibility_applicantRevision   |
            | applicationRevision | global   | Request_eligibility_applicationRevision |
            | applicantId         | global   | Request_eligibility_applicantId         |
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_existingTaxDeclarationStatus | Y          |
            | Response_getApplicationStatus_statusCode                   | InProgress |
            | Response_getApplicationStatus_agreedOverdraftLimit         | 0          |
            | Response_getApplicationStatus_isEligibleForAccount         | true       |
            | Response_getApplicationStatus_sortCode                     | 123456     |
            | Response_getApplicationStatus_accountNumber                | 10000009   |
            | Response_getApplicationStatus_serviceStatusCode            | 0          |
            | Response_getApplicationStatus_statusRetry                  | false      |
            | Response_getApplicationStatus_statusType                   | Success    |
            | Response_getApplicationStatus_statusMessage                | Success    |
    
    @happyPath @TestCaseKey=CAO-T960
    Scenario: IPC service Get application status for eligibility check passed and existingTaxDeclarationStatus is B: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1211111111"
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
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_existingTaxDeclarationStatus | B          |
            | Response_getApplicationStatus_statusCode                   | InProgress |
            | Response_getApplicationStatus_agreedOverdraftLimit         | 100.00     |
            | Response_getApplicationStatus_isEligibleForAccount         | true       |
            | Response_getApplicationStatus_sortCode                     | 123456     |
            | Response_getApplicationStatus_accountNumber                | 12345678   |
            | Response_getApplicationStatus_serviceStatusCode            | 0          |
            | Response_getApplicationStatus_statusRetry                  | false      |
            | Response_getApplicationStatus_statusType                   | Success    |
            | Response_getApplicationStatus_statusMessage                | Success    |

    @happyPath @TestCaseKey=CAO-T961
    Scenario: IPC service Get application status for eligibility check passed and existingTaxDeclarationStatus is D: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1221111111"
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
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_existingTaxDeclarationStatus | D          |
            | Response_getApplicationStatus_statusCode                   | InProgress |
            | Response_getApplicationStatus_agreedOverdraftLimit         | 100.00     |
            | Response_getApplicationStatus_isEligibleForAccount         | true       |
            | Response_getApplicationStatus_sortCode                     | 123456     |
            | Response_getApplicationStatus_accountNumber                | 12345678   |
            | Response_getApplicationStatus_serviceStatusCode            | 0          |
            | Response_getApplicationStatus_statusRetry                  | false      |
            | Response_getApplicationStatus_statusType                   | Success    |
            | Response_getApplicationStatus_statusMessage                | Success    |

    @happyPath @TestCaseKey=CAO-T962
    Scenario: IPC service Get application status for eligibility check passed and existingTaxDeclarationStatus is N: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1241111111"
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
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_existingTaxDeclarationStatus | N          |
            | Response_getApplicationStatus_statusCode                   | InProgress |
            | Response_getApplicationStatus_agreedOverdraftLimit         | 100.00     |
            | Response_getApplicationStatus_isEligibleForAccount         | true       |
            | Response_getApplicationStatus_sortCode                     | 123456     |
            | Response_getApplicationStatus_accountNumber                | 12345678   |
            | Response_getApplicationStatus_serviceStatusCode            | 0          |
            | Response_getApplicationStatus_statusRetry                  | false      |
            | Response_getApplicationStatus_statusType                   | Success    |
            | Response_getApplicationStatus_statusMessage                | Success    |

    @happyPath @TestCaseKey=CAO-T963
    Scenario: IPC service Get application status for eligibility check passed and existingTaxDeclarationStatus is X: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1251111111"
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
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_existingTaxDeclarationStatus | X          |
            | Response_getApplicationStatus_statusCode                   | InProgress |
            | Response_getApplicationStatus_agreedOverdraftLimit         | 100.00     |
            | Response_getApplicationStatus_isEligibleForAccount         | true       |
            | Response_getApplicationStatus_sortCode                     | 123456     |
            | Response_getApplicationStatus_accountNumber                | 12345678   |
            | Response_getApplicationStatus_serviceStatusCode            | 0          |
            | Response_getApplicationStatus_statusRetry                  | false      |
            | Response_getApplicationStatus_statusType                   | Success    |
            | Response_getApplicationStatus_statusMessage                | Success    |

    @happyPath @TestCaseKey=CAO-T964
    Scenario: IPC service Get application status for create application passed: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111119"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_existingTaxDeclarationStatus |           |
            | Response_getApplicationStatus_statusCode                   | Initiated |
            | Response_getApplicationStatus_isEligibleForAccount         | null      |



    # *************************************************
    #             ERROR SCENARIOS
    # *************************************************

    @error @100 @TestCaseKey=CAO-T965
    Scenario: IPC service Get application status for Invalid email address: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111114"
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
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_statusCode           | Terminated                                                                        |
            | Response_getApplicationStatus_isEligibleForAccount | false                                                                             |
            | Response_getApplicationStatus_errorCode            | 100                                                                               |
            | Response_getApplicationStatus_errorMessage         | Customer details held on CIS incomplete or incorrect - Email Address is not valid |

    @error @100 @TestCaseKey=CAO-T966
    Scenario: IPC service Get application status for Invalid home address: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111125"
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
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_statusCode           | Terminated                                                                              |
            | Response_getApplicationStatus_isEligibleForAccount | false                                                                                   |
            | Response_getApplicationStatus_errorCode            | 100                                                                                     |
            | Response_getApplicationStatus_errorMessage         | Customer details held on CIS incomplete or incorrect - BFPO or Postcode is not provided |

    @error @100 @TestCaseKey=CAO-T967
    Scenario: IPC service Get application status for Invalid mobile number: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111134"
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
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_statusCode           | Terminated                                                                           |
            | Response_getApplicationStatus_isEligibleForAccount | false                                                                                |
            | Response_getApplicationStatus_errorCode            | 100                                                                                  |
            | Response_getApplicationStatus_errorMessage         | Customer details held on CIS incomplete or incorrect - Mobile Number is not provided |

    @error @110 @TestCaseKey=CAO-T968
    Scenario: IPC service Get application status for customer whose IDstatus is not confirmed: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1271111111"
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
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_statusCode           | Terminated                   |
            | Response_getApplicationStatus_isEligibleForAccount | false                        |
            | Response_getApplicationStatus_errorCode            | 110                          |
            | Response_getApplicationStatus_errorMessage         | Customer is not ID Confirmed |

    @error @120 @TestCaseKey=CAO-T969
    Scenario: IPC service Get application status for customer is deceased: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1291111111"
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
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_statusCode           | Terminated                          |
            | Response_getApplicationStatus_isEligibleForAccount | false                               |
            | Response_getApplicationStatus_errorCode            | 120                                 |
            | Response_getApplicationStatus_errorMessage         | CIS indicating customer is deceased |

    @error @130 @TestCaseKey=CAO-T970
    Scenario: IPC service Get application status for customer is set as No Trace: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1321111112"
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
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_statusCode           | Terminated                                 |
            | Response_getApplicationStatus_isEligibleForAccount | false                                      |
            | Response_getApplicationStatus_errorCode            | 130                                        |
            | Response_getApplicationStatus_errorMessage         | CIS indicating customer is set as No Trace |

    @error @140 @TestCaseKey=CAO-T971
    Scenario: IPC service Get application status for Customer not entitled to the preferred target product: HTTP 200
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
            | accountNumber       | 10000003 | Request_eligibility_accountNo           |
            | applicantRevision   | global   | Request_eligibility_applicantRevision   |
            | applicationRevision | global   | Request_eligibility_applicationRevision |
            | applicantId         | global   | Request_eligibility_applicantId         |
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_statusCode           | Terminated                                            |
            | Response_getApplicationStatus_isEligibleForAccount | false                                                 |
            | Response_getApplicationStatus_errorCode            | 140                                                   |
            | Response_getApplicationStatus_errorMessage         | Customer not entitled to the preferred target product |

    @error @100 @TestCaseKey=CAO-T972
    Scenario: IPC service Get application status for Customer or account address is non UK: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1361111111"
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
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_statusCode           | Terminated                                                               |
            | Response_getApplicationStatus_isEligibleForAccount | false                                                                    |
            | Response_getApplicationStatus_errorCode            | 100                                                                      |
            | Response_getApplicationStatus_errorMessage         | Customer details held on CIS incomplete or incorrect - Country is not UK |

    @error @200 @TestCaseKey=CAO-T973
    Scenario: IPC service Get application status for account number does not belong to the customer: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111122"
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
            | sortCode            | 100560 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_statusCode           | Terminated                                     |
            | Response_getApplicationStatus_isEligibleForAccount | false                                          |
            | Response_getApplicationStatus_errorCode            | 200                                            |
            | Response_getApplicationStatus_errorMessage         | Account number does not belong to the customer |

    @error @210 @TestCaseKey=CAO-T974
    Scenario: IPC service Get application status for account is overdrawn beyond the agreed overdraft limit: HTTP 200
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
            | accountNumber       | 10000005 | Request_eligibility_accountNo           |
            | applicantRevision   | global   | Request_eligibility_applicantRevision   |
            | applicationRevision | global   | Request_eligibility_applicationRevision |
            | applicantId         | global   | Request_eligibility_applicantId         |
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_statusCode           | Terminated                                             |
            | Response_getApplicationStatus_isEligibleForAccount | false                                                  |
            | Response_getApplicationStatus_errorCode            | 210                                                    |
            | Response_getApplicationStatus_errorMessage         | Account is overdrawn beyond the agreed overdraft limit |

    @error @230 @TestCaseKey=CAO-T975
    Scenario: IPC service Get application status for account is in collections: HTTP 200
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
            | accountNumber       | 10000010 | Request_eligibility_accountNo           |
            | applicantRevision   | global   | Request_eligibility_applicantRevision   |
            | applicationRevision | global   | Request_eligibility_applicationRevision |
            | applicantId         | global   | Request_eligibility_applicantId         |
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_statusCode           | Terminated                |
            | Response_getApplicationStatus_isEligibleForAccount | false                     |
            | Response_getApplicationStatus_errorCode            | 230                       |
            | Response_getApplicationStatus_errorMessage         | Account is In Collections |

    @error @220 @TestCaseKey=CAO-T976
    Scenario: IPC service Get application status for Account locked by SAP: HTTP 200
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
            | sortCode            | 100001 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_statusCode           | Terminated                                     |
            | Response_getApplicationStatus_isEligibleForAccount | false                                          |
            | Response_getApplicationStatus_errorCode            | 220                                            |
            | Response_getApplicationStatus_errorMessage         | Account locked by SAP - 1001 SID Account Block |

    @error @500 @TestCaseKey=CAO-T977
    Scenario: IPC service Get application status for Original account is Joint account: HTTP 200
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
            | accountNumber       | 10000001 | Request_eligibility_accountNo           |
            | applicantRevision   | global   | Request_eligibility_applicantRevision   |
            | applicationRevision | global   | Request_eligibility_applicationRevision |
            | applicantId         | global   | Request_eligibility_applicantId         |
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_statusCode           | Terminated                |
            | Response_getApplicationStatus_isEligibleForAccount | false                     |
            | Response_getApplicationStatus_errorCode            | 500                       |
            | Response_getApplicationStatus_errorMessage         | Original account is Joint |

    @error @401 @TestCaseKey=CAO-T978
    Scenario: IPC service Get application status for Authorization token is missing: HTTP 401
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
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id |  |
        When I send the request
        Then I verify the response status code as "401"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_serviceStatusCode | 401                                                   |
            | Response_getApplicationStatus_statusRetry       | false                                                 |
            | Response_getApplicationStatus_statusType        | BusinessException                                     |
            | Response_getApplicationStatus_statusMessage     | Authorization is not available or can not be verified |

    @error @401 @TestCaseKey=CAO-T979
    Scenario: IPC service Get application status for Authorization token is not valid: HTTP 401
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
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I "update" the following global values
            | jwt | hfysdgfsd |
        And I set the headers for the request
            | x-journey-id  |           |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "401"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_serviceStatusCode | 401                                                   |
            | Response_getApplicationStatus_statusRetry       | false                                                 |
            | Response_getApplicationStatus_statusType        | BusinessException                                     |
            | Response_getApplicationStatus_statusMessage     | Authorization is not available or can not be verified |

    @error @400 @TestCaseKey=CAO-T980
    Scenario: IPC service Get application status for JourneyId is missing: HTTP 400
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
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_serviceStatusCode | 400                             |
            | Response_getApplicationStatus_statusRetry       | false                           |
            | Response_getApplicationStatus_statusType        | BusinessException               |
            | Response_getApplicationStatus_statusMessage     | Missing x-journey-id in request |

    @error @400 @TestCaseKey=CAO-T981
    Scenario: IPC service Get application status for JourneyId is not valid: HTTP 400
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
        And I send the request
        And I verify the response status code as "200"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I "update" the following global values
            | x-journey-id | 111111 |
        And I set the headers for the request
            | Authorization |        |
            | x-journey-Id  | 123456 |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_serviceStatusCode | 400                                    |
            | Response_getApplicationStatus_statusRetry       | false                                  |
            | Response_getApplicationStatus_statusType        | BusinessException                      |
            | Response_getApplicationStatus_statusMessage     | Valid x-journey-id required in request |

    @error @400 @TestCaseKey=CAO-T982
    Scenario: IPC service Get application status for Invalid AppId sent in the request: HTTP 400
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
        And I send the request
        And I verify the response status code as "200"
        And I "update" the following global values
            | appId | hfysdgfsd |
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | Authorization |  |
            | x-journey-Id  |  |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_serviceStatusCode | 400                             |
            | Response_getApplicationStatus_statusRetry       | false                           |
            | Response_getApplicationStatus_statusType        | BusinessException               |
            | Response_getApplicationStatus_statusMessage     | Valid AppId required in request |
