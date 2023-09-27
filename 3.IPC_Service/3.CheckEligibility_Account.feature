@api @ipc @regression  @checkEligibility     @account
Feature: Scenarios for the IPC service Check Eligibility end point based on account number

    Background: Generate JWT for use in token handler calls
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111119"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number "123456 12345678 " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"

    # *************************************************
    #              HAPPY PATH SCENARIOS
    # *************************************************

    #IPC Service - /ipcservice/api/v1/applications/{appId}/eligibility
    @happyPath  @TestCaseKey=CAO-T547   
    Scenario: IPC Check Eligibility service for Sole account, Positive balance & Facility Level 4: HTTP 200
        And I set "PUT" method for "CheckEligibility"
        Given I set the "CheckEligibility" request body
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
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I save the response fields from "GetApplication" in global data after "checkEligibility" to validate AppStore
        And I verify the response status code as "200"
        And I verify the complete response body should be "GetApplication_PUTEligibility_true"
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I save the response fields from "GetApplicant" in global data after "checkEligibility" to validate AppStore
        And I verify the response status code as "200"
        And I verify the complete response body should be "GetApplicant_PUTEligibility_true"

    @happyPath  @TestCaseKey=CAO-T548
    Scenario: IPC Check Eligibility service for Available balance is negative and equal to overdraft limit and facility level is 4: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | accountNumber       | 10000006 | Request_eligibility_accountNo           |
            | applicantRevision   | global   | Request_eligibility_applicantRevision   |
            | applicationRevision | global   | Request_eligibility_applicationRevision |
            | applicantId         | global   | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | true                           |
            | RAS_application_statusCode                                        | InProgress                     |
            | RAS_application_statusReason                                      | Applicant eligible for account |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                           |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                           |
            | RAS_application_offeredProducts_promotions_isDenied               | false                          |
            | RAS_application_existingProducts_agreedOverdraftLimit             | 100                            |
            | RAS_application_existingProducts_currentBalance                   | 100                            |
            | RAS_application_existingProducts_availableBalance                 | -100                           |
            | RAS_application_offeredProducts_availableAccountFacility          | 4                              |
            | RAS_application_applicant_cardType                                | X2X DEBIT                 |
            | RAS_application_existingAccount_SortCode                          | 123456                         |
            | RAS_application_existingAccount_Number                            | 10000006                       |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @happyPath @TestCaseKey=CAO-T583
    Scenario: IPC Check Eligibility service for an account with with zero overdraft limit and facility level is 4: HTTP 200
        Given I set the "CheckEligibility" request body
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
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | true                           |
            | RAS_application_statusCode                                        | InProgress                     |
            | RAS_application_statusReason                                      | Applicant eligible for account |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                           |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                           |
            | RAS_application_offeredProducts_promotions_isDenied               | false                          |
            | RAS_application_existingProducts_agreedOverdraftLimit             | 0.00                           |
            | RAS_application_existingProducts_currentBalance                   | 100.00                         |
            | RAS_application_existingProducts_availableBalance                 | 100.00                         |
            | RAS_application_offeredProducts_availableAccountFacility          | 4                              |
            | RAS_application_applicant_cardType                                | X2X DEBIT                 |
            | RAS_application_existingAccount_SortCode                          | 123456                         |
            | RAS_application_existingAccount_Number                            | 10000009                       |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @happyPath  @TestCaseKey=CAO-T552
    Scenario: IPC Check Eligibility service for an account with facility level of 6 - Valid for Direct Debit Card: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | accountNumber       | 10000004 | Request_eligibility_accountNo           |
            | applicantRevision   | global   | Request_eligibility_applicantRevision   |
            | applicationRevision | global   | Request_eligibility_applicationRevision |
            | applicantId         | global   | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | true                           |
            | RAS_application_statusCode                                        | InProgress                     |
            | RAS_application_statusReason                                      | Applicant eligible for account |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                           |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                           |
            | RAS_application_offeredProducts_promotions_isDenied               | false                          |
            | RAS_application_existingProducts_agreedOverdraftLimit             | 100.00                         |
            | RAS_application_offeredProducts_availableAccountFacility          | 4                              |
            | RAS_application_applicant_cardType                                | VISA DEBIT                      |
            | RAS_application_existingAccount_SortCode                          | 123456                         |
            | RAS_application_existingAccount_Number                            | 10000004                       |
            | RAS_application_existingProducts_currentBalance                   | 100                            |
            | RAS_application_existingProducts_availableBalance                 | 100                            |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @happyPath  @TestCaseKey=CAO-T744
    Scenario: IPC Check Eligibility service for an account with lock code that is not being actioned by IPC: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100044 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | true                           |
            | RAS_application_statusCode                                        | InProgress                     |
            | RAS_application_statusReason                                      | Applicant eligible for account |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                           |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                           |
            | RAS_application_existingAccount_SortCode                          | 100044                         |
            | RAS_application_existingAccount_Number                            | 12345678                       |
            | RAS_application_existingProducts_lockType                         | Freeze Charges                 |
            | RAS_application_existingProducts_lockId                           | 001044                         |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    # *************************************************************
    #           #######   ERROR SCENARIOS   #########
    # *************************************************************

    # *************************************************************
    #    Pre-Check for overdrawn balance
    # *************************************************************

    @EligibilityFailure @TestCaseKey=CAO-T546 
    Scenario: IPC Check Eligibility service for Available balance exceeds the allowed overdraft limit:HTTP 200
        Given I set the "CheckEligibility" request body
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
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                  |
            | Response_eligibility_errorCode    | 210                                                    |
            | Response_eligibility_errorMessage | Account is overdrawn beyond the agreed overdraft limit |
        Then I verify the response status code as "200"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                                  |
            | RAS_application_statusCode                                        | Terminated                                             |
            | RAS_application_statusReason                                      | Applicant not eligible for account                     |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                   |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                   |
            | RAS_application_existingProducts_currentBalance                   | 100.00                                                 |
            | RAS_application_existingProducts_availableBalance                 | -100.01                                                |
            | RAS_application_existingProducts_agreedOverdraftLimit             | 100.00                                                 |
            | RAS_application_eligibility_errorCode                             | 210                                                    |
            | RAS_application_eligibility_errorMessage                          | Account is overdrawn beyond the agreed overdraft limit |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure @TestCaseKey=CAO-T585
    Scenario: IPC Check Eligibility service for an account without the overdraft limit and overdrawn balance : HTTP 200
        Given I set the "CheckEligibility" request body
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
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                  |
            | Response_eligibility_errorCode    | 210                                                    |
            | Response_eligibility_errorMessage | Account is overdrawn beyond the agreed overdraft limit |
        Then I verify the response status code as "200"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                                  |
            | RAS_application_statusCode                                        | Terminated                                             |
            | RAS_application_statusReason                                      | Applicant not eligible for account                     |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                   |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                   |
            | RAS_application_existingProducts_currentBalance                   | 100.00                                                 |
            | RAS_application_existingProducts_availableBalance                 | -10.00                                                 |
            | RAS_application_existingProducts_agreedOverdraftLimit             | 0.00                                                   |
            | RAS_application_eligibility_errorCode                             | 210                                                    |
            | RAS_application_eligibility_errorMessage                          | Account is overdrawn beyond the agreed overdraft limit |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    # *************************************************
    #    Pre-Check for Account in Collection
    # *************************************************
    
    @EligibilityFailure @TestCaseKey=CAO-T931   
    Scenario: IPC Check Eligibility service for an account in collections: HTTP 200
        Given I set the "CheckEligibility" request body
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
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                     |
            | Response_eligibility_errorCode    | 230                       |
            | Response_eligibility_errorMessage | Account is In Collections |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                              |
            | RAS_application_statusCode                                        | Terminated                         |
            | RAS_application_statusReason                                      | Applicant not eligible for account |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                               |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                               |
            | RAS_application_eligibility_errorCode                             | 230                                |
            | RAS_application_eligibility_errorMessage                          | Account is In Collections          |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    # *************************************************
    #    Pre-Check for Sole Account
    # *************************************************

    @EligibilityFailure @TestCaseKey=CAO-T549
    Scenario: IPC Check Eligibility service for a joint account, facility level is 4 and valid for X2X card: HTTP 200
        Given I set the "CheckEligibility" request body
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
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                     |
            | Response_eligibility_errorCode    | 500                       |
            | Response_eligibility_errorMessage | Original account is Joint |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                              |
            | RAS_application_statusCode                                        | Terminated                         |
            | RAS_application_statusReason                                      | Applicant not eligible for account |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                               |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                               |
            | RAS_application_offeredProducts_availableAccountFacility          | 4                                  |
            | RAS_application_existingProducts_isJointAccount                   | true                               |
            | RAS_application_eligibility_errorCode                             | 500                                |
            | RAS_application_eligibility_errorMessage                          | Original account is Joint          |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    # **************************************
    #    Pre-Check for Facility Level
    # **************************************

    @EligibilityFailure  @TestCaseKey=CAO-T550
    Scenario: IPC Check Eligibility service for an account with facility level of 1 - Invalid for IPC: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | accountNumber       | 10000002 | Request_eligibility_accountNo           |
            | applicantRevision   | global   | Request_eligibility_applicantRevision   |
            | applicationRevision | global   | Request_eligibility_applicationRevision |
            | applicantId         | global   | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                 |
            | Response_eligibility_errorCode    | 140                                                   |
            | Response_eligibility_errorMessage | Customer not entitled to the preferred target product |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                                 |
            | RAS_application_statusCode                                        | Terminated                                            |
            | RAS_application_statusReason                                      | Applicant not eligible for account                    |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                  |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                  |
            | RAS_application_offeredProducts_availableAccountFacility          | 4                                                     |
            | RAS_application_eligibility_errorCode                             | 140                                                   |
            | RAS_application_eligibility_errorMessage                          | Customer not entitled to the preferred target product |
        And I verify the following param value is "api_null" with response param value
            | RAS_application_applicant_cardType |  |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T551
    Scenario: IPC Check Eligibility service for an account with facility level of 2 - Invalid for IPC : HTTP 200
        Given I set the "CheckEligibility" request body
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
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                 |
            | Response_eligibility_errorCode    | 140                                                   |
            | Response_eligibility_errorMessage | Customer not entitled to the preferred target product |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                                 |
            | RAS_application_statusCode                                        | Terminated                                            |
            | RAS_application_statusReason                                      | Applicant not eligible for account                    |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                  |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                  |
            | RAS_application_offeredProducts_availableAccountFacility          | 4                                                     |
            | RAS_application_eligibility_errorCode                             | 140                                                   |
            | RAS_application_eligibility_errorMessage                          | Customer not entitled to the preferred target product |
        And I verify the following param value is "api_null" with response param value
            | RAS_application_applicant_cardType |  |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    # **************************************
    #    Pre-Check for SAP Account Lock
    # **************************************

    @EligibilityFailure  @TestCaseKey=CAO-T688
    Scenario: IPC Check Eligibility service for an account with lock code 001001: HTTP 200                                                                                                                                                                       |
        Given I set the "CheckEligibility" request body
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
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                          |
            | Response_eligibility_errorCode    | 220                                            |
            | Response_eligibility_errorMessage | Account locked by SAP - 1001 SID Account Block |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                          |
            | RAS_application_statusCode                                        | Terminated                                     |
            | RAS_application_statusReason                                      | Applicant not eligible for account             |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                           |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                           |
            | RAS_application_existingAccount_SortCode                          | 100001                                         |
            | RAS_application_existingAccount_Number                            | 12345678                                       |
            | RAS_application_eligibility_errorCode                             | 220                                            |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1001 SID Account Block |
            | RAS_application_existingProducts_lockType                         | SID Account Block                              |
            | RAS_application_existingProducts_lockId                           | 001001                                         |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T689
    Scenario: IPC Check Eligibility service for an account with lock code 001002: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100002 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                        |
            | Response_eligibility_errorCode    | 220                                          |
            | Response_eligibility_errorMessage | Account locked by SAP - 1002 Suspect Account |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                        |
            | RAS_application_statusCode                                        | Terminated                                   |
            | RAS_application_statusReason                                      | Applicant not eligible for account           |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                         |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                         |
            | RAS_application_existingAccount_SortCode                          | 100002                                       |
            | RAS_application_existingAccount_Number                            | 12345678                                     |
            | RAS_application_eligibility_errorCode                             | 220                                          |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1002 Suspect Account |
            | RAS_application_existingProducts_lockType                         | Suspect Account                              |
            | RAS_application_existingProducts_lockId                           | 001002                                       |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T690
    Scenario: IPC Check Eligibility service for an account with lock code 001003: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100003 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                             |
            | Response_eligibility_errorCode    | 220                                               |
            | Response_eligibility_errorMessage | Account locked by SAP - 1003 Head Office Referral |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                             |
            | RAS_application_statusCode                                        | Terminated                                        |
            | RAS_application_statusReason                                      | Applicant not eligible for account                |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                              |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                              |
            | RAS_application_existingAccount_SortCode                          | 100003                                            |
            | RAS_application_existingAccount_Number                            | 12345678                                          |
            | RAS_application_eligibility_errorCode                             | 220                                               |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1003 Head Office Referral |
            | RAS_application_existingProducts_lockType                         | Head Office Referral                              |
            | RAS_application_existingProducts_lockId                           | 001003                                            |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T691
    Scenario: IPC Check Eligibility service for an account with lock code 001004: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100004 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                |
            | Response_eligibility_errorCode    | 220                                                  |
            | Response_eligibility_errorMessage | Account locked by SAP - 1004 No Withdrawals (legacy) |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                                |
            | RAS_application_statusCode                                        | Terminated                                           |
            | RAS_application_statusReason                                      | Applicant not eligible for account                   |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                 |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                 |
            | RAS_application_existingAccount_SortCode                          | 100004                                               |
            | RAS_application_existingAccount_Number                            | 12345678                                             |
            | RAS_application_eligibility_errorCode                             | 220                                                  |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1004 No Withdrawals (legacy) |
            | RAS_application_existingProducts_lockType                         | No Withdrawals (legacy)                              |
            | RAS_application_existingProducts_lockId                           | 001004                                               |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T692
    Scenario: IPC Check Eligibility service for an account with lock code 001005: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100005 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                 |
            | Response_eligibility_errorCode    | 220                                                   |
            | Response_eligibility_errorMessage | Account locked by SAP - 1005 Customer Bankrupt (sole) |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                                 |
            | RAS_application_statusCode                                        | Terminated                                            |
            | RAS_application_statusReason                                      | Applicant not eligible for account                    |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                  |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                  |
            | RAS_application_existingAccount_SortCode                          | 100005                                                |
            | RAS_application_existingAccount_Number                            | 12345678                                              |
            | RAS_application_eligibility_errorCode                             | 220                                                   |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1005 Customer Bankrupt (sole) |
            | RAS_application_existingProducts_lockType                         | Customer Bankrupt (sole)                              |
            | RAS_application_existingProducts_lockId                           | 001005                                                |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T693
    Scenario: IPC Check Eligibility service for an account with lock code 001006: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100006 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                  |
            | Response_eligibility_errorCode    | 220                                                    |
            | Response_eligibility_errorMessage | Account locked by SAP - 1006 Customer Bankrupt (joint) |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                                  |
            | RAS_application_statusCode                                        | Terminated                                             |
            | RAS_application_statusReason                                      | Applicant not eligible for account                     |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                   |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                   |
            | RAS_application_existingAccount_SortCode                          | 100006                                                 |
            | RAS_application_existingAccount_Number                            | 12345678                                               |
            | RAS_application_eligibility_errorCode                             | 220                                                    |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1006 Customer Bankrupt (joint) |
            | RAS_application_existingProducts_lockType                         | Customer Bankrupt (joint)                              |
            | RAS_application_existingProducts_lockId                           | 001006                                                 |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T694
    Scenario: IPC Check Eligibility service for an account with lock code 001007: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100007 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                           |
            | Response_eligibility_errorCode    | 220                                             |
            | Response_eligibility_errorMessage | Account locked by SAP - 1007 No Withdrawals SID |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                           |
            | RAS_application_statusCode                                        | Terminated                                      |
            | RAS_application_statusReason                                      | Applicant not eligible for account              |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                            |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                            |
            | RAS_application_existingAccount_SortCode                          | 100007                                          |
            | RAS_application_existingAccount_Number                            | 12345678                                        |
            | RAS_application_eligibility_errorCode                             | 220                                             |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1007 No Withdrawals SID |
            | RAS_application_existingProducts_lockType                         | No Withdrawals SID                              |
            | RAS_application_existingProducts_lockId                           | 001007                                          |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T695
    Scenario: IPC Check Eligibility service for an account with lock code 001008: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100008 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                       |
            | Response_eligibility_errorCode    | 220                                                         |
            | Response_eligibility_errorMessage | Account locked by SAP - 1008 No Withdrawals (Lending Ctrl.) |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                                       |
            | RAS_application_statusCode                                        | Terminated                                                  |
            | RAS_application_statusReason                                      | Applicant not eligible for account                          |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                        |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                        |
            | RAS_application_existingAccount_SortCode                          | 100008                                                      |
            | RAS_application_existingAccount_Number                            | 12345678                                                    |
            | RAS_application_eligibility_errorCode                             | 220                                                         |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1008 No Withdrawals (Lending Ctrl.) |
            | RAS_application_existingProducts_lockType                         | No Withdrawals (Lending Ctrl.)                              |
            | RAS_application_existingProducts_lockId                           | 001008                                                      |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T696
    Scenario: IPC Check Eligibility service for an account with lock code 001009: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100009 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                           |
            | Response_eligibility_errorCode    | 220                                             |
            | Response_eligibility_errorMessage | Account locked by SAP - 1009 Account in Dispute |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                           |
            | RAS_application_statusCode                                        | Terminated                                      |
            | RAS_application_statusReason                                      | Applicant not eligible for account              |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                            |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                            |
            | RAS_application_existingAccount_SortCode                          | 100009                                          |
            | RAS_application_existingAccount_Number                            | 12345678                                        |
            | RAS_application_eligibility_errorCode                             | 220                                             |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1009 Account in Dispute |
            | RAS_application_existingProducts_lockType                         | Account in Dispute                              |
            | RAS_application_existingProducts_lockId                           | 001009                                          |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T697
    Scenario: IPC Check Eligibility service for an account with lock code 001011: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100011 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                              |
            | Response_eligibility_errorCode    | 220                                                |
            | Response_eligibility_errorMessage | Account locked by SAP - 1011 Unathorised Borrowing |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                              |
            | RAS_application_statusCode                                        | Terminated                                         |
            | RAS_application_statusReason                                      | Applicant not eligible for account                 |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                               |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                               |
            | RAS_application_existingAccount_SortCode                          | 100011                                             |
            | RAS_application_existingAccount_Number                            | 12345678                                           |
            | RAS_application_eligibility_errorCode                             | 220                                                |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1011 Unathorised Borrowing |
            | RAS_application_existingProducts_lockType                         | Unathorised Borrowing                              |
            | RAS_application_existingProducts_lockId                           | 001011                                             |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T698
    Scenario: IPC Check Eligibility service for an account with lock code 001012: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100012 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                           |
            | Response_eligibility_errorCode    | 220                                             |
            | Response_eligibility_errorMessage | Account locked by SAP - 1012 Termination Bundle |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                           |
            | RAS_application_statusCode                                        | Terminated                                      |
            | RAS_application_statusReason                                      | Applicant not eligible for account              |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                            |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                            |
            | RAS_application_existingAccount_SortCode                          | 100012                                          |
            | RAS_application_existingAccount_Number                            | 12345678                                        |
            | RAS_application_eligibility_errorCode                             | 220                                             |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1012 Termination Bundle |
            | RAS_application_existingProducts_lockType                         | Termination Bundle                              |
            | RAS_application_existingProducts_lockId                           | 001012                                          |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T699
    Scenario: IPC Check Eligibility service for an account with lock code 001013: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100013 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                  |
            | Response_eligibility_errorCode    | 220                                                    |
            | Response_eligibility_errorMessage | Account locked by SAP - 1013 Account Forced Downgraded |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                                  |
            | RAS_application_statusCode                                        | Terminated                                             |
            | RAS_application_statusReason                                      | Applicant not eligible for account                     |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                   |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                   |
            | RAS_application_existingAccount_SortCode                          | 100013                                                 |
            | RAS_application_existingAccount_Number                            | 12345678                                               |
            | RAS_application_eligibility_errorCode                             | 220                                                    |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1013 Account Forced Downgraded |
            | RAS_application_existingProducts_lockType                         | Account Forced Downgraded                              |
            | RAS_application_existingProducts_lockId                           | 001013                                                 |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T700
    Scenario: IPC Check Eligibility service for an account with lock code 001017: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100017 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                       |
            | Response_eligibility_errorCode    | 220                                                         |
            | Response_eligibility_errorMessage | Account locked by SAP - 1017 Court of Protection Card Restr |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                                       |
            | RAS_application_statusCode                                        | Terminated                                                  |
            | RAS_application_statusReason                                      | Applicant not eligible for account                          |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                        |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                        |
            | RAS_application_existingAccount_SortCode                          | 100017                                                      |
            | RAS_application_existingAccount_Number                            | 12345678                                                    |
            | RAS_application_eligibility_errorCode                             | 220                                                         |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1017 Court of Protection Card Restr |
            | RAS_application_existingProducts_lockType                         | Court of Protection Card Restr                              |
            | RAS_application_existingProducts_lockId                           | 001017                                                      |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T701
    Scenario: IPC Check Eligibility service for an account with lock code 001018: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100018 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                   |
            | Response_eligibility_errorCode    | 220                                                     |
            | Response_eligibility_errorMessage | Account locked by SAP - 1018 UN Sanctions Branch Access |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                                   |
            | RAS_application_statusCode                                        | Terminated                                              |
            | RAS_application_statusReason                                      | Applicant not eligible for account                      |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                    |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                    |
            | RAS_application_existingAccount_SortCode                          | 100018                                                  |
            | RAS_application_existingAccount_Number                            | 12345678                                                |
            | RAS_application_eligibility_errorCode                             | 220                                                     |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1018 UN Sanctions Branch Access |
            | RAS_application_existingProducts_lockType                         | UN Sanctions Branch Access                              |
            | RAS_application_existingProducts_lockId                           | 001018                                                  |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T702
    Scenario: IPC Check Eligibility service for an account with lock code 001019: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100019 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                      |
            | Response_eligibility_errorCode    | 220                                                        |
            | Response_eligibility_errorMessage | Account locked by SAP - 1019 UN Sanctions Payment Mandates |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                                      |
            | RAS_application_statusCode                                        | Terminated                                                 |
            | RAS_application_statusReason                                      | Applicant not eligible for account                         |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                       |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                       |
            | RAS_application_existingAccount_SortCode                          | 100019                                                     |
            | RAS_application_existingAccount_Number                            | 12345678                                                   |
            | RAS_application_eligibility_errorCode                             | 220                                                        |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1019 UN Sanctions Payment Mandates |
            | RAS_application_existingProducts_lockType                         | UN Sanctions Payment Mandates                              |
            | RAS_application_existingProducts_lockId                           | 001019                                                     |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T703
    Scenario: IPC Check Eligibility service for an account with lock code 001020: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100020 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                      |
            | Response_eligibility_errorCode    | 220                                                        |
            | Response_eligibility_errorMessage | Account locked by SAP - 1020 UN Sanctions Branch & PaymMdt |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                                      |
            | RAS_application_statusCode                                        | Terminated                                                 |
            | RAS_application_statusReason                                      | Applicant not eligible for account                         |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                       |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                       |
            | RAS_application_existingAccount_SortCode                          | 100020                                                     |
            | RAS_application_existingAccount_Number                            | 12345678                                                   |
            | RAS_application_eligibility_errorCode                             | 220                                                        |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1020 UN Sanctions Branch & PaymMdt |
            | RAS_application_existingProducts_lockType                         | UN Sanctions Branch & PaymMdt                              |
            | RAS_application_existingProducts_lockId                           | 001020                                                     |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T704
    Scenario: IPC Check Eligibility service for an account with lock code 001021: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100021 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                       |
            | Response_eligibility_errorCode    | 220                                                         |
            | Response_eligibility_errorMessage | Account locked by SAP - 1021 Criminal Financial Court Order |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                                       |
            | RAS_application_statusCode                                        | Terminated                                                  |
            | RAS_application_statusReason                                      | Applicant not eligible for account                          |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                        |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                        |
            | RAS_application_existingAccount_SortCode                          | 100021                                                      |
            | RAS_application_existingAccount_Number                            | 12345678                                                    |
            | RAS_application_eligibility_errorCode                             | 220                                                         |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1021 Criminal Financial Court Order |
            | RAS_application_existingProducts_lockType                         | Criminal Financial Court Order                              |
            | RAS_application_existingProducts_lockId                           | 001021                                                      |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T705
    Scenario: IPC Check Eligibility service for an account with lock code 001022: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100022 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                       |
            | Response_eligibility_errorCode    | 220                                                         |
            | Response_eligibility_errorMessage | Account locked by SAP - 1022 Criminal Court Order BranchAcc |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                                       |
            | RAS_application_statusCode                                        | Terminated                                                  |
            | RAS_application_statusReason                                      | Applicant not eligible for account                          |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                        |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                        |
            | RAS_application_existingAccount_SortCode                          | 100022                                                      |
            | RAS_application_existingAccount_Number                            | 12345678                                                    |
            | RAS_application_eligibility_errorCode                             | 220                                                         |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1022 Criminal Court Order BranchAcc |
            | RAS_application_existingProducts_lockType                         | Criminal Court Order BranchAcc                              |
            | RAS_application_existingProducts_lockId                           | 001022                                                      |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T706
    Scenario: IPC Check Eligibility service for an account with lock code 001023: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100023 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                      |
            | Response_eligibility_errorCode    | 220                                                        |
            | Response_eligibility_errorMessage | Account locked by SAP - 1023 Criminal Court Order PaymMdts |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                                      |
            | RAS_application_statusCode                                        | Terminated                                                 |
            | RAS_application_statusReason                                      | Applicant not eligible for account                         |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                       |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                       |
            | RAS_application_existingAccount_SortCode                          | 100023                                                     |
            | RAS_application_existingAccount_Number                            | 12345678                                                   |
            | RAS_application_eligibility_errorCode                             | 220                                                        |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1023 Criminal Court Order PaymMdts |
            | RAS_application_existingProducts_lockType                         | Criminal Court Order PaymMdts                              |
            | RAS_application_existingProducts_lockId                           | 001023                                                     |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T707
    Scenario: IPC Check Eligibility service for an account with lock code 001024: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100024 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                       |
            | Response_eligibility_errorCode    | 220                                                         |
            | Response_eligibility_errorMessage | Account locked by SAP - 1024 Criminal Court Order Br & PMdt |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                                       |
            | RAS_application_statusCode                                        | Terminated                                                  |
            | RAS_application_statusReason                                      | Applicant not eligible for account                          |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                        |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                        |
            | RAS_application_existingAccount_SortCode                          | 100024                                                      |
            | RAS_application_existingAccount_Number                            | 12345678                                                    |
            | RAS_application_eligibility_errorCode                             | 220                                                         |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1024 Criminal Court Order Br & PMdt |
            | RAS_application_existingProducts_lockType                         | Criminal Court Order Br & PMdt                              |
            | RAS_application_existingProducts_lockId                           | 001024                                                      |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T708
    Scenario: IPC Check Eligibility service for an account with lock code 001025: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100025 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                     |
            | Response_eligibility_errorCode    | 220                                       |
            | Response_eligibility_errorMessage | Account locked by SAP - 1025 UN Sanctions |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                     |
            | RAS_application_statusCode                                        | Terminated                                |
            | RAS_application_statusReason                                      | Applicant not eligible for account        |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                      |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                      |
            | RAS_application_existingAccount_SortCode                          | 100025                                    |
            | RAS_application_existingAccount_Number                            | 12345678                                  |
            | RAS_application_eligibility_errorCode                             | 220                                       |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1025 UN Sanctions |
            | RAS_application_existingProducts_lockType                         | UN Sanctions                              |
            | RAS_application_existingProducts_lockId                           | 001025                                    |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T709
    Scenario: IPC Check Eligibility service for an account with lock code 001026: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100026 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                          |
            | Response_eligibility_errorCode    | 220                                            |
            | Response_eligibility_errorMessage | Account locked by SAP - 1026 Civil Court Order |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                          |
            | RAS_application_statusCode                                        | Terminated                                     |
            | RAS_application_statusReason                                      | Applicant not eligible for account             |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                           |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                           |
            | RAS_application_existingAccount_SortCode                          | 100026                                         |
            | RAS_application_existingAccount_Number                            | 12345678                                       |
            | RAS_application_eligibility_errorCode                             | 220                                            |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1026 Civil Court Order |
            | RAS_application_existingProducts_lockType                         | Civil Court Order                              |
            | RAS_application_existingProducts_lockId                           | 001026                                         |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T710
    Scenario: IPC Check Eligibility service for an account with lock code 001027: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100027 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                   |
            | Response_eligibility_errorCode    | 220                                                     |
            | Response_eligibility_errorMessage | Account locked by SAP - 1027 Civil Court Order w Limits |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                                   |
            | RAS_application_statusCode                                        | Terminated                                              |
            | RAS_application_statusReason                                      | Applicant not eligible for account                      |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                    |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                    |
            | RAS_application_existingAccount_SortCode                          | 100027                                                  |
            | RAS_application_existingAccount_Number                            | 12345678                                                |
            | RAS_application_eligibility_errorCode                             | 220                                                     |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1027 Civil Court Order w Limits |
            | RAS_application_existingProducts_lockType                         | Civil Court Order w Limits                              |
            | RAS_application_existingProducts_lockId                           | 001027                                                  |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T711
    Scenario: IPC Check Eligibility service for an account with lock code 001028: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100028 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                       |
            | Response_eligibility_errorCode    | 220                                                         |
            | Response_eligibility_errorMessage | Account locked by SAP - 1028 Civil Court Order LargePaymLim |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                                       |
            | RAS_application_statusCode                                        | Terminated                                                  |
            | RAS_application_statusReason                                      | Applicant not eligible for account                          |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                        |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                        |
            | RAS_application_existingAccount_SortCode                          | 100028                                                      |
            | RAS_application_existingAccount_Number                            | 12345678                                                    |
            | RAS_application_eligibility_errorCode                             | 220                                                         |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1028 Civil Court Order LargePaymLim |
            | RAS_application_existingProducts_lockType                         | Civil Court Order LargePaymLim                              |
            | RAS_application_existingProducts_lockId                           | 001028                                                      |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T712
    Scenario: IPC Check Eligibility service for an account with lock code 001046: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100046 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                |
            | Response_eligibility_errorCode    | 220                                                  |
            | Response_eligibility_errorMessage | Account locked by SAP - 1046 No Withdrawals (Retail) |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                                |
            | RAS_application_statusCode                                        | Terminated                                           |
            | RAS_application_statusReason                                      | Applicant not eligible for account                   |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                 |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                 |
            | RAS_application_existingAccount_SortCode                          | 100046                                               |
            | RAS_application_existingAccount_Number                            | 12345678                                             |
            | RAS_application_eligibility_errorCode                             | 220                                                  |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1046 No Withdrawals (Retail) |
            | RAS_application_existingProducts_lockType                         | No Withdrawals (Retail)                              |
            | RAS_application_existingProducts_lockId                           | 001046                                               |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T713
    Scenario: IPC Check Eligibility service for an account with lock code 001073: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100073 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                 |
            | Response_eligibility_errorCode    | 220                                                   |
            | Response_eligibility_errorMessage | Account locked by SAP - 1073 No Withdrawals (Collect) |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                                 |
            | RAS_application_statusCode                                        | Terminated                                            |
            | RAS_application_statusReason                                      | Applicant not eligible for account                    |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                  |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                  |
            | RAS_application_existingAccount_SortCode                          | 100073                                                |
            | RAS_application_existingAccount_Number                            | 12345678                                              |
            | RAS_application_eligibility_errorCode                             | 220                                                   |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1073 No Withdrawals (Collect) |
            | RAS_application_existingProducts_lockType                         | No Withdrawals (Collect)                              |
            | RAS_application_existingProducts_lockId                           | 001073                                                |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T714
    Scenario: IPC Check Eligibility service for an account with lock code 001078: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100078 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                               |
            | Response_eligibility_errorCode    | 220                                                 |
            | Response_eligibility_errorMessage | Account locked by SAP - 1078 Temp UN Sanctions - PH |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                               |
            | RAS_application_statusCode                                        | Terminated                                          |
            | RAS_application_statusReason                                      | Applicant not eligible for account                  |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                |
            | RAS_application_existingAccount_SortCode                          | 100078                                              |
            | RAS_application_existingAccount_Number                            | 12345678                                            |
            | RAS_application_eligibility_errorCode                             | 220                                                 |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1078 Temp UN Sanctions - PH |
            | RAS_application_existingProducts_lockType                         | Temp UN Sanctions - PH                              |
            | RAS_application_existingProducts_lockId                           | 001078                                              |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T715
    Scenario: IPC Check Eligibility service for an account with lock code 001079: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100079 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                |
            | Response_eligibility_errorCode    | 220                                                  |
            | Response_eligibility_errorMessage | Account locked by SAP - 1079 Temp UN Sanctions - NPH |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                                |
            | RAS_application_statusCode                                        | Terminated                                           |
            | RAS_application_statusReason                                      | Applicant not eligible for account                   |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                 |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                 |
            | RAS_application_existingAccount_SortCode                          | 100079                                               |
            | RAS_application_existingAccount_Number                            | 12345678                                             |
            | RAS_application_eligibility_errorCode                             | 220                                                  |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1079 Temp UN Sanctions - NPH |
            | RAS_application_existingProducts_lockType                         | Temp UN Sanctions - NPH                              |
            | RAS_application_existingProducts_lockId                           | 001079                                               |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T716
    Scenario: IPC Check Eligibility service for an account with lock code 003002: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 103002 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                 |
            | Response_eligibility_errorCode    | 220                                   |
            | Response_eligibility_errorMessage | Account locked by SAP - 3002 No Trace |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                 |
            | RAS_application_statusCode                                        | Terminated                            |
            | RAS_application_statusReason                                      | Applicant not eligible for account    |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                  |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                  |
            | RAS_application_existingAccount_SortCode                          | 103002                                |
            | RAS_application_existingAccount_Number                            | 12345678                              |
            | RAS_application_eligibility_errorCode                             | 220                                   |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 3002 No Trace |
            | RAS_application_existingProducts_lockType                         | No Trace                              |
            | RAS_application_existingProducts_lockId                           | 003002                                |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T717
    Scenario: IPC Check Eligibility service for an account with lock code 003003: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 103003 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                               |
            | Response_eligibility_errorCode    | 220                                                 |
            | Response_eligibility_errorMessage | Account locked by SAP - 3003 Customer Deceased Lock |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                               |
            | RAS_application_statusCode                                        | Terminated                                          |
            | RAS_application_statusReason                                      | Applicant not eligible for account                  |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                                |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                                |
            | RAS_application_existingAccount_SortCode                          | 103003                                              |
            | RAS_application_existingAccount_Number                            | 12345678                                            |
            | RAS_application_eligibility_errorCode                             | 220                                                 |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 3003 Customer Deceased Lock |
            | RAS_application_existingProducts_lockType                         | Customer Deceased Lock                              |
            | RAS_application_existingProducts_lockId                           | 003003                                              |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @EligibilityFailure  @TestCaseKey=CAO-T718
    Scenario: IPC Check Eligibility service for an account with multiple locks and only one lock code is returned in response: HTTP 200
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100999 | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                     |
            | Response_eligibility_errorCode    | 220                                       |
            | Response_eligibility_errorMessage | Account locked by SAP - 1025 UN Sanctions |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | false                                     |
            | RAS_application_statusCode                                        | Terminated                                |
            | RAS_application_statusReason                                      | Applicant not eligible for account        |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                                      |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                                      |
            | RAS_application_existingAccount_SortCode                          | 100999                                    |
            | RAS_application_existingAccount_Number                            | 12345678                                  |
            | RAS_application_eligibility_errorCode                             | 220                                       |
            | RAS_application_eligibility_errorMessage                          | Account locked by SAP - 1025 UN Sanctions |
            | RAS_application_existingProducts_lockType                         | Freeze Charges                            |
            | RAS_application_existingProducts_lockId                           | 001044                                    |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    # ****************************************************************************
    #    Field Level Validation for Header and Request
    # ****************************************************************************

    @error   @400   @TestCaseKey=CAO-T554
    Scenario: IPC Check Eligibility service when the AppId is invalid:HTTP 400
        Given I set the "CheckEligibility" request body
        And I "update" the following global values
            | appId | hfysdgfsd |
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
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                             |
            | Response_error_type    | BusinessException               |
            | Response_error_retry   | false                           |
            | Response_error_message | Valid AppId required in request |

    @error   @400   @TestCaseKey=CAO-T555
    Scenario: IPC Check Eligibility service when the Original Product Id is provided incorrectly :HTTP 400
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | productId           | 70     | Request_eligibility_productId           |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                         |
            | Response_error_type    | BusinessException                           |
            | Response_error_retry   | false                                       |
            | Response_error_message | Valid OriginalProductID required in request |

    @error   @400   @TestCaseKey=CAO-T556
    Scenario: IPC Check Eligibility service when New Product Id is provided incorrectly :HTTP 400
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | newProductId        | 70     | Request_eligibility_newProductId        |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                       |
            | Response_error_type    | BusinessException                         |
            | Response_error_retry   | false                                     |
            | Response_error_message | Valid TargetProductID required in request |

    @error   @401   @TestCaseKey=CAO-T557
    Scenario: IPC Check Eligibility service when invalid authorisation token is provided :HTTP 401
        Given I prepare the "CheckEligibility" payload details
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I "update" the following global values
            | jwt | hfysdgfsd |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "401"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 401                                                   |
            | Response_error_type    | BusinessException                                     |
            | Response_error_retry   | false                                                 |
            | Response_error_message | Authorization is not available or can not be verified |

    @error   @400   @TestCaseKey=CAO-T558
    Scenario: IPC Check Eligibility service when invalid (less than 6 digit) Sort code (not a 6 digit number) is provided:HTTP 400
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 123    | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                |
            | Response_error_type    | BusinessException                  |
            | Response_error_retry   | false                              |
            | Response_error_message | Valid SortCode required in request |

    @error   @400   @TestCaseKey=CAO-T586
    Scenario: IPC Check Eligibility service when invalid (less than 8 digit) Account Number (not a 8 digit number) is provided :HTTP 400
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | accountNumber       | 123    | Request_eligibility_accountNo           |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                     |
            | Response_error_type    | BusinessException                       |
            | Response_error_retry   | false                                   |
            | Response_error_message | Valid AccountNumber required in request |

    @error   @400   @TestCaseKey=CAO-T560
    Scenario: IPC Check Eligibility service when invalid(6 character) Sort code (not a 6 digit number) is provided :HTTP 400
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | abcdef | Request_eligibility_sortCode            |
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                |
            | Response_error_type    | BusinessException                  |
            | Response_error_retry   | false                              |
            | Response_error_message | Valid SortCode required in request |

    @error   @400   @TestCaseKey=CAO-T561
    Scenario: IPC Check Eligibility service when invalid (8 character) Account Number (not a 8 digit number) is provided:HTTP 400
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | accountNumber       | abcdefgh | Request_eligibility_accountNo           |
            | applicantRevision   | global   | Request_eligibility_applicantRevision   |
            | applicationRevision | global   | Request_eligibility_applicationRevision |
            | applicantId         | global   | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                     |
            | Response_error_type    | BusinessException                       |
            | Response_error_retry   | false                                   |
            | Response_error_message | Valid AccountNumber required in request |

    # *************************************************************
    #    Mandatory/Optional Field Validation
    # *************************************************************

    @error   @401   @TestCaseKey=CAO-T562
    Scenario: IPC Check Eligibility service when authorisation token is not provided :HTTP 401
        And I set "PUT" method for "CheckEligibility"
        Given I set the "CheckEligibility" request body
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "401"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 401                                                   |
            | Response_error_type    | BusinessException                                     |
            | Response_error_retry   | false                                                 |
            | Response_error_message | Authorization is not available or can not be verified |

    @error   @404   @TestCaseKey=CAO-T563   
    Scenario: IPC Check Eligibility service when applicant Id is not provided :HTTP 400
        And I set "PUT" method for "CheckEligibility"
        Given I set the "CheckEligibility" request body
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | remove | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                            |
            | Response_error_type    | BusinessException              |
            | Response_error_retry   | false                          |
            | Response_error_message | Missing ApplicantId in request |

    @error   @400   @TestCaseKey=CAO-T564
    Scenario: IPC Check Eligibility service when Sort Code is not provided :HTTP 400
        And I set "PUT" method for "CheckEligibility"
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
            | sortCode            | remove | Request_eligibility_sortCode            |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                         |
            | Response_error_type    | BusinessException           |
            | Response_error_retry   | false                       |
            | Response_error_message | Missing SortCode in request |

    @error   @400   @TestCaseKey=CAO-T565
    Scenario: IPC Check Eligibility service when Account Number is not provided :HTTP 400
        And I set "PUT" method for "CheckEligibility"
        Given I set the "CheckEligibility" request body
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
            | accountNumber       | remove | Request_eligibility_accountNo           |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                              |
            | Response_error_type    | BusinessException                |
            | Response_error_retry   | false                            |
            | Response_error_message | Missing AccountNumber in request |

    @error   @400   @TestCaseKey=CAO-T566
    Scenario: IPC Check Eligibility service when Original Product Id is not provided :HTTP 400
        And I set "PUT" method for "CheckEligibility"
        Given I set the "CheckEligibility" request body
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
            | productId           | remove | Request_eligibility_productId           |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                  |
            | Response_error_type    | BusinessException                    |
            | Response_error_retry   | false                                |
            | Response_error_message | Missing OriginalProductID in request |

    @error   @400   @TestCaseKey=CAO-T567
    Scenario: IPC Check Eligibility service when New Product Id is not provided :HTTP 400
        And I set "PUT" method for "CheckEligibility"
        Given I set the "CheckEligibility" request body
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
            | newProductId        | remove | Request_eligibility_newProductId        |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                |
            | Response_error_type    | BusinessException                  |
            | Response_error_retry   | false                              |
            | Response_error_message | Missing TargetProductID in request |

    @error   @400   @TestCaseKey=CAO-T920   
    Scenario: IPC Check Eligibility service when Applicant Revision is not provided :HTTP 400
        And I set "PUT" method for "CheckEligibility"
        Given I set the "CheckEligibility" request body
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | remove | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                  |
            | Response_error_type    | BusinessException                    |
            | Response_error_retry   | false                                |
            | Response_error_message | Missing ApplicantRevision in request |

    @error   @400   @TestCaseKey=CAO-T921
    Scenario: IPC Check Eligibility service when Application Revision is not provided :HTTP 400
        And I set "PUT" method for "CheckEligibility"
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | remove | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                    |
            | Response_error_type    | BusinessException                      |
            | Response_error_retry   | false                                  |
            | Response_error_message | Missing ApplicationRevision in request |

    @error   @400   @TestCaseKey=CAO-T922
    Scenario: IPC Check Eligibility service when invalid Applicant Revision is provided :HTTP 400
        And I set "PUT" method for "CheckEligibility"
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | 1111   | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                         |
            | Response_error_type    | BusinessException                           |
            | Response_error_retry   | false                                       |
            | Response_error_message | Valid ApplicantRevision required in request |

    @error   @400   @TestCaseKey=CAO-T923
    Scenario: IPC Check Eligibility service when invalid Applicant Id is provided :HTTP 400
        Given I set the "CheckEligibility" request body
        And I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | 1111   | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                   |
            | Response_error_type    | BusinessException                     |
            | Response_error_retry   | false                                 |
            | Response_error_message | Valid ApplicantId required in request |

    @error   @400   @TestCaseKey=CAO-T924
    Scenario: IPC Check Eligibility service when invalid journey Id is provided :HTTP 400
        And I set "PUT" method for "CheckEligibility"
        Given I set the "CheckEligibility" request body
        And I set the config for the request to "default"
        And I "update" the following global values
            | x-journey-id | hfysdgfsd |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                    |
            | Response_error_type    | BusinessException                      |
            | Response_error_retry   | false                                  |
            | Response_error_message | Valid x-journey-id required in request |

    @error   @400   @TestCaseKey=CAO-T925
    Scenario: IPC Check Eligibility service when journey Id is not provided :HTTP 400
        And I set "PUT" method for "CheckEligibility"
        Given I set the "CheckEligibility" request body
        And I set the config for the request to "default"
        And I set the headers for the request
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                             |
            | Response_error_type    | BusinessException               |
            | Response_error_retry   | false                           |
            | Response_error_message | Missing x-journey-id in request |

    # *************************************************************
    #    Eligibility API Failure
    # *************************************************************

    @error   @500 @TestCaseKey=CAO-T881  
    Scenario: IPC Check Eligibility service for customer with FATCA Question selfCertDeclaration as empty string: HTTP 500
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1201111111"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
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
        Then I verify the response status code as "500"