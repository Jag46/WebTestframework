@api  @ipc  @regression  @checkEligibility   @customer  
Feature: Scenarios for the IPC service Check Eligibility end point based on customer number for Eligibility success

    # *************************************************
    #           HAPPY PATH SCENARIOS
    # *************************************************

    #****************************************************************************************************************
    #   Pre-Checks for customer details (valid firstname, Lastname, address, mobile, email and ID status)
    # ***************************************************************************************************************

    @happyPath @TestCaseKey=CAO-T955   
    Scenario: IPC Check Eligibility service for valid UK home address with building name, mobile, email address and ID status: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1234567890"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
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

    @happyPath @TestCaseKey=CAO-T725
    Scenario: IPC Check Eligibility service for Firstname and Lastname are available and middlename not available: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1011111111"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | true                           |
            | RAS_application_statusCode                                        | InProgress                     |
            | RAS_application_statusReason                                      | Applicant eligible for account |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                           |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                           |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_null" with response param value
            | RAS_applicant_middleNames |  |
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_firstName | Alexandria |
            | RAS_applicant_lastName  | O'Neil     |

    @happyPath @TestCaseKey=CAO-T745
    Scenario: IPC Check Eligibility service for email valid format but not deliverable: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1331111112"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | true                           |
            | RAS_application_statusCode                                        | InProgress                     |
            | RAS_application_statusReason                                      | Applicant eligible for account |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                           |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                           |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_contactInformation_email | bounceback@email.test.xe |

    @happyPath @TestCaseKey=CAO-T747
    Scenario: IPC Check Eligibility service for valid email Id with prefix "3133-abc.def_123@mail.com": HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111112"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | true                           |
            | RAS_application_statusCode                                        | InProgress                     |
            | RAS_application_statusReason                                      | Applicant eligible for account |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                           |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                           |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_contactInformation_email | 3133-abc.def_123@mail.com |

    @happyPath @TestCaseKey=CAO-T748
    Scenario: IPC Check Eligibility service for valid email Id with co.uk email domain address: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111118"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | true                           |
            | RAS_application_statusCode                                        | InProgress                     |
            | RAS_application_statusReason                                      | Applicant eligible for account |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                           |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                           |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_contactInformation_email | aa@nationwide.co.uk |

    @happyPath @TestCaseKey=CAO-T926
    Scenario: IPC Check Eligibility service for valid Reverend title: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111141"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | true                           |
            | RAS_application_statusCode                                        | InProgress                     |
            | RAS_application_statusReason                                      | Applicant eligible for account |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                           |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                           |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_title     | 42  |
            | RAS_applicant_titleText | Rev |

    #********************************************************************
    #   Pre-Checks: Check whether customer isDead or NoTrace scenarios
    # *******************************************************************

    @happyPath @TestCaseKey=CAO-T568
    Scenario: IPC Check Eligibility service for Deceased status (2 which is false) and ownerNoTraceIndicator as false: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1281111111"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isJoint          | false         |
            | RAS_application_journeyType      | Authenticated |
            | RAS_application_applicantId      | {applicantId} |
            | RAS_application_isOwnerTraceable | true          |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_isDeceased | false |

    @happyPath @TestCaseKey=CAO-T1043
    Scenario: IPC Check Eligibility service for contactPointUnavailableReason is 0:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111147"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
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
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isJoint          | false         |
            | RAS_application_journeyType      | Authenticated |
            | RAS_application_applicantId      | {applicantId} |
            | RAS_application_isOwnerTraceable | true          |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_isDeceased | false |

    @happyPath @TestCaseKey=CAO-T1044
    Scenario: IPC Check Eligibility service for contactPointUnavailableReason is empty:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111148"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
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
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isJoint          | false         |
            | RAS_application_journeyType      | Authenticated |
            | RAS_application_applicantId      | {applicantId} |
            | RAS_application_isOwnerTraceable | true          |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_isDeceased | false |

    @happyPath @TestCaseKey=CAO-T1045
    Scenario: IPC Check Eligibility service for contactPointUnavailableReason is null:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111149"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
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
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isJoint          | false         |
            | RAS_application_journeyType      | Authenticated |
            | RAS_application_applicantId      | {applicantId} |
            | RAS_application_isOwnerTraceable | true          |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_isDeceased | false |

    #********************************************************************
    #   Pre-Checks: Customer Mobile Number
    # *******************************************************************

    @happyPath @TestCaseKey=CAO-T721
    Scenario: IPC Check Eligibility service for valid Mobile number starting with 07(11 digits): HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "222222222"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | true                           |
            | RAS_application_statusCode                                        | InProgress                     |
            | RAS_application_statusReason                                      | Applicant eligible for account |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                           |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                           |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_contactInformation_mobileNumber | 07467735718 |

    @happyPath @TestCaseKey=CAO-T722
    Scenario: IPC Check Eligibility service for valid Mobile number starting with 7(10 digits): HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1391111111"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | true                           |
            | RAS_application_statusCode                                        | InProgress                     |
            | RAS_application_statusReason                                      | Applicant eligible for account |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                           |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                           |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_contactInformation_mobileNumber | 07467735718 |

    @happyPath @TestCaseKey=CAO-T724
    Scenario: IPC Check Eligibility service for mobile number with spaces: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1371111111"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | true                           |
            | RAS_application_statusCode                                        | InProgress                     |
            | RAS_application_statusReason                                      | Applicant eligible for account |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                           |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                           |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_contactInformation_mobileNumber | 07467735718 |

    @happyPath @TestCaseKey=CAO-T801
    Scenario: IPC Check Eligibility service for mobile number with multiple spaces: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111133"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | true                           |
            | RAS_application_statusCode                                        | InProgress                     |
            | RAS_application_statusReason                                      | Applicant eligible for account |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                           |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                           |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_contactInformation_mobileNumber | 07467735745 |

    # ********************************************************************
    #   Pre-Checks: Customer Address
    # *******************************************************************

    #Scenario 1
    @happyPath @TestCaseKey=CAO-T867
    Scenario: IPC Check Eligibility service for valid UK BFPO address with 3 address lines: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1411111113"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | true                           |
            | RAS_application_statusCode                                        | InProgress                     |
            | RAS_application_statusReason                                      | Applicant eligible for account |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                           |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                           |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_address_serviceNoRankAndName | 1234123 Captain Pete |
            | RAS_applicant_address_unitRegiment         | Beta Unit            |
            | RAS_applicant_address_operationName        | Antarctica           |
            | RAS_applicant_address_bfpoNumber           | 3919                 |
            | RAS_applicant_address_isBfpoAddress        | true                 |
            | RAS_applicant_address_addressLocationId    | 2                    |
            | RAS_applicant_address_addressType          | 1                    |
            | RAS_applicant_address_isPrimaryAddress     | true                 |
            | RAS_applicant_isDeceased                   | false                |

    #Scenario 2
    @happyPath @TestCaseKey=CAO-T720
    Scenario: IPC Check Eligibility service for valid UK BFPO address with 2 address lines: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1411111112"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | true                           |
            | RAS_application_statusCode                                        | InProgress                     |
            | RAS_application_statusReason                                      | Applicant eligible for account |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                           |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                           |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_address_serviceNoRankAndName | 1234123 Captain Pete |
            | RAS_applicant_address_unitRegiment         | Beta Unit Antarctica |
            | RAS_applicant_address_bfpoNumber           | 5489                 |
            | RAS_applicant_address_isBfpoAddress        | true                 |
            | RAS_applicant_address_addressLocationId    | 2                    |
            | RAS_applicant_address_addressType          | 1                    |
            | RAS_applicant_address_isPrimaryAddress     | true                 |
            | RAS_applicant_isDeceased                   | false                |

    #Scenario 3
    @happyPath @TestCaseKey=CAO-T800    
    Scenario: IPC Check Eligibility service with Home address having buildingNumber value passed without buildingName: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111127"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | true                           |
            | RAS_application_statusCode                                        | InProgress                     |
            | RAS_application_statusReason                                      | Applicant eligible for account |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                           |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                           |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_address_houseNameOrNumber | 404  |
            | RAS_applicant_address_addressLineOne    | Pond Street |
            | RAS_applicant_address_townOrCity        | SHEFFIELD   |
            | RAS_applicant_address_postcode          | S1 1AA      |
            | RAS_applicant_address_country           | GB          |
            | RAS_applicant_address_isBfpoAddress     | false       |
            | RAS_applicant_address_addressLocationId | 1           |
            | RAS_applicant_address_addressType       | 1           |
            | RAS_applicant_address_isPrimaryAddress  | true        |
            | RAS_applicant_isDeceased                | false       |

    # Scenario 4:
    @happyPath @TestCaseKey=CAO-T868
    Scenario: IPC Check Eligibility service for Home address with Building Name and DependentLocality: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111139"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | true                           |
            | RAS_application_statusCode                                        | InProgress                     |
            | RAS_application_statusReason                                      | Applicant eligible for account |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                           |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                           |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_address_buildingName      | Sheffield Delivery Office |
            | RAS_applicant_address_addressLineOne    | Pond Street               |
            | RAS_applicant_address_area              | Southside                 |
            | RAS_applicant_address_townOrCity        | SHEFFIELD                 |
            | RAS_applicant_address_postcode          | S1 1AA                    |
            | RAS_applicant_address_country           | GB                        |
            | RAS_applicant_address_isBfpoAddress     | false                     |
            | RAS_applicant_address_addressLocationId | 1                         |
            | RAS_applicant_address_addressType       | 1                         |
            | RAS_applicant_address_isPrimaryAddress  | true                      |
            | RAS_applicant_isDeceased                | false                     |

    # Scenario 5
    @happyPath @TestCaseKey=CAO-T869    
    Scenario: IPC Check Eligibility service for Home address with Building Name and Building Number : HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111137"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | true                           |
            | RAS_application_statusCode                                        | InProgress                     |
            | RAS_application_statusReason                                      | Applicant eligible for account |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                           |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                           |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_address_buildingName      | Sheffield Delivery Office |
            | RAS_applicant_address_houseNameOrNumber | 404                |
            | RAS_applicant_address_addressLineOne    | Pond Street               |
            | RAS_applicant_address_townOrCity        | SHEFFIELD                 |
            | RAS_applicant_address_postcode          | S1 1AA                    |
            | RAS_applicant_address_country           | GB                        |
            | RAS_applicant_address_isBfpoAddress     | false                     |
            | RAS_applicant_address_addressLocationId | 1                         |
            | RAS_applicant_address_addressType       | 1                         |
            | RAS_applicant_address_isPrimaryAddress  | true                      |
            | RAS_applicant_isDeceased                | false                     |

    # Scenario 6
    @happyPath @TestCaseKey=CAO-T870    
    Scenario: IPC Check Eligibility service for Home address with Unit number and building number: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111138"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | true                           |
            | RAS_application_statusCode                                        | InProgress                     |
            | RAS_application_statusReason                                      | Applicant eligible for account |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                           |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                           |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_address_buildingName      | Unit 6      |
            | RAS_applicant_address_houseNameOrNumber | 404  |
            | RAS_applicant_address_addressLineOne    | Pond Street |
            | RAS_applicant_address_townOrCity        | SHEFFIELD   |
            | RAS_applicant_address_postcode          | S1 1AA      |
            | RAS_applicant_address_country           | GB          |
            | RAS_applicant_address_isBfpoAddress     | false       |
            | RAS_applicant_address_addressLocationId | 1           |
            | RAS_applicant_address_addressType       | 1           |
            | RAS_applicant_address_isPrimaryAddress  | true        |
            | RAS_applicant_isDeceased                | false       |

    # Scenario 7
    @happyPath @TestCaseKey=CAO-T871
    Scenario: IPC Check Eligibility service for Home address with Unit Number, Building Name and DependentLocality: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111142"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                              | true                           |
            | RAS_application_statusCode                                        | InProgress                     |
            | RAS_application_statusReason                                      | Applicant eligible for account |
            | RAS_application_offeredProducts_isInternalProductSwitch           | true                           |
            | RAS_application_existingProducts_isInternalProductChangeCandidate | true                           |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_address_buildingName      | Unit 6, Sheffield Delivery Office |
            | RAS_applicant_address_addressLineOne    | Pond Street                       |
            | RAS_applicant_address_area              | Southside                         |
            | RAS_applicant_address_townOrCity        | SHEFFIELD                         |
            | RAS_applicant_address_postcode          | S1 1AA                            |
            | RAS_applicant_address_country           | GB                                |
            | RAS_applicant_address_isBfpoAddress     | false                             |
            | RAS_applicant_address_addressLocationId | 1                                 |
            | RAS_applicant_address_addressType       | 1                                 |
            | RAS_applicant_address_isPrimaryAddress  | true                              |
            | RAS_applicant_isDeceased                | false                             |

    #Scenario 8
    @happyPath @TestCaseKey=CAO-T872    
    Scenario: IPC Check Eligibility service for Home address with DependentThoroughfare and DependentLocality: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111140"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount | true                           |
            | RAS_application_statusCode           | InProgress                     |
            | RAS_application_statusReason         | Applicant eligible for account |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_address_houseNameOrNumber | 404  |
            | RAS_applicant_address_addressLineOne    | The Close    |
            | RAS_applicant_address_addressLineTwo    | Pond Street |
            | RAS_applicant_address_area              | Southside   |
            | RAS_applicant_address_townOrCity        | SHEFFIELD   |
            | RAS_applicant_address_postcode          | S1 1AA      |
            | RAS_applicant_address_country           | GB          |
            | RAS_applicant_address_isBfpoAddress     | false       |
            | RAS_applicant_address_addressLocationId | 1           |
            | RAS_applicant_address_addressType       | 1           |
            | RAS_applicant_address_isPrimaryAddress  | true        |
            | RAS_applicant_isDeceased                | false       |

    # ********************************************************************
    #   Pre-Checks: Double check account belongs to customer
    # *******************************************************************

    @happyPath @TestCaseKey=CAO-T739
    Scenario: IPC Check Eligibility service for account belongs to customer: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111119"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | true                           |
            | RAS_application_statusCode               | InProgress                     |
            | RAS_application_statusReason             | Applicant eligible for account |
            | RAS_application_existingAccount_SortCode | 123456                         |
            | RAS_application_existingAccount_Number   | 12345678                       |
            | RAS_application_applicant_cisNo          | 1111111119                     |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |
            | RAS_applicant_isDeceased  | false         |

    # #********************************************************************
    #   Marketing Preference - save data in AppStore
    # *******************************************************************

    @happyPath @TestCaseKey=CAO-T873
    Scenario: IPC Check Eligibility service for customer with Marketing preference Email not available: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1131111111"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount | true                           |
            | RAS_application_statusCode           | InProgress                     |
            | RAS_application_statusReason         | Applicant eligible for account |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_marketingPref_isPhonePreferred | true |
            | RAS_applicant_marketingPref_isMailPreferred  | true |
        And I verify the following param value is "api_null" with response param value
            | RAS_applicant_marketingPref_isEmailPreferred |  |

    @happyPath @TestCaseKey=CAO-T874
    Scenario: IPC Check Eligibility service for customer with Marketing preference Telephone not available: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1141111111"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount | true                           |
            | RAS_application_statusCode           | InProgress                     |
            | RAS_application_statusReason         | Applicant eligible for account |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_marketingPref_isEmailPreferred | true |
            | RAS_applicant_marketingPref_isMailPreferred  | true |
        And I verify the following param value is "api_null" with response param value
            | RAS_applicant_marketingPref_isPhonePreferred |  |

    @happyPath @TestCaseKey=CAO-T875
    Scenario: IPC Check Eligibility service for customer with Marketing preference Post not available: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1151111111"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount | true                           |
            | RAS_application_statusCode           | InProgress                     |
            | RAS_application_statusReason         | Applicant eligible for account |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_marketingPref_isEmailPreferred | true |
            | RAS_applicant_marketingPref_isPhonePreferred | true |
        And I verify the following param value is "api_null" with response param value
            | RAS_applicant_marketingPref_isMailPreferred |  |

    @happyPath @TestCaseKey=CAO-T876
    Scenario: IPC Check Eligibility service for customer with Marketing preference Post and telephone not available: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1161111111"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount | true                           |
            | RAS_application_statusCode           | InProgress                     |
            | RAS_application_statusReason         | Applicant eligible for account |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_marketingPref_isEmailPreferred | true |
        And I verify the following param value is "api_null" with response param value
            | RAS_applicant_marketingPref_isPhonePreferred |  |
            | RAS_applicant_marketingPref_isMailPreferred  |  |

    @happyPath @TestCaseKey=CAO-T877
    Scenario: IPC Check Eligibility service for customer with Marketing preference Email and post not available: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1171111111"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount | true                           |
            | RAS_application_statusCode           | InProgress                     |
            | RAS_application_statusReason         | Applicant eligible for account |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_marketingPref_isPhonePreferred | true |
        And I verify the following param value is "api_null" with response param value
            | RAS_applicant_marketingPref_isEmailPreferred |  |
            | RAS_applicant_marketingPref_isMailPreferred  |  |

    @happyPath @TestCaseKey=CAO-T878
    Scenario: IPC Check Eligibility service for customer with Marketing preference Email and telephone not available: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1181111111"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount | true                           |
            | RAS_application_statusCode           | InProgress                     |
            | RAS_application_statusReason         | Applicant eligible for account |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_marketingPref_isMailPreferred | true |
        And I verify the following param value is "api_null" with response param value
            | RAS_applicant_marketingPref_isEmailPreferred |  |
            | RAS_applicant_marketingPref_isPhonePreferred |  |

    @happyPath @TestCaseKey=CAO-T879
    Scenario: IPC Check Eligibility service for customer with all 3 Marketing preferences not available: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1301111111"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount | true                           |
            | RAS_application_statusCode           | InProgress                     |
            | RAS_application_statusReason         | Applicant eligible for account |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_null" with response param value
            | RAS_applicant_marketingPref_isEmailPreferred |  |
            | RAS_applicant_marketingPref_isPhonePreferred |  |
            | RAS_applicant_marketingPref_isMailPreferred  |  |

    @happyPath @TestCaseKey=CAO-T880
    Scenario: IPC Check Eligibility service for customer with Marketing preference available and are No: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1191111111"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount | true                           |
            | RAS_application_statusCode           | InProgress                     |
            | RAS_application_statusReason         | Applicant eligible for account |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_marketingPref_isEmailPreferred | false |
            | RAS_applicant_marketingPref_isPhonePreferred | false |
            | RAS_applicant_marketingPref_isMailPreferred  | false |

    @happyPath @TestCaseKey=CAO-T1046  
    Scenario: IPC Check Eligibility service for customer with Marketing preference returned are ?: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111150"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount | true                           |
            | RAS_application_statusCode           | InProgress                     |
            | RAS_application_statusReason         | Applicant eligible for account |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_null" with response param value
            | RAS_applicant_marketingPref_isEmailPreferred |  |
            | RAS_applicant_marketingPref_isPhonePreferred |  |
            | RAS_applicant_marketingPref_isMailPreferred  |  |

    #********************************************************************
    #   FATCA Question - save data in AppStore
    # *******************************************************************

    @happyPath @TestCaseKey=CAO-T882
    Scenario: IPC Check Eligibility service for customer with FATCA Question available selfCertDeclaration with value B: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1211111111"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                   | true                           |
            | RAS_application_statusCode                             | InProgress                     |
            | RAS_application_statusReason                           | Applicant eligible for account |
            | RAS_application_applicant_ExistingTaxDeclarationStatus | B                              |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_isDeceased  | false         |
            | RAS_applicant_applicantId | {applicantId} |

    @happyPath @TestCaseKey=CAO-T1047
    Scenario: IPC Check Eligibility service for customer with FATCA Question available selfCertDeclaration with value D: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1221111111"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                   | true                           |
            | RAS_application_statusCode                             | InProgress                     |
            | RAS_application_statusReason                           | Applicant eligible for account |
            | RAS_application_applicant_ExistingTaxDeclarationStatus | D                              |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_isDeceased  | false         |
            | RAS_applicant_applicantId | {applicantId} |

    @happyPath @TestCaseKey=CAO-T956 
    Scenario: IPC Check Eligibility service for customer with FATCA Question not available selfCertDeclaration with value Y: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1231111111"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                   | true                           |
            | RAS_application_statusCode                             | InProgress                     |
            | RAS_application_statusReason                           | Applicant eligible for account |
            | RAS_application_applicant_ExistingTaxDeclarationStatus | Y                              |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_isDeceased  | false         |
            | RAS_applicant_applicantId | {applicantId} |

    @happyPath @TestCaseKey=CAO-T885
    Scenario: IPC Check Eligibility service for customer with FATCA Question not available selfCertDeclaration with value N: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1241111111"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                   | true                           |
            | RAS_application_statusCode                             | InProgress                     |
            | RAS_application_statusReason                           | Applicant eligible for account |
            | RAS_application_applicant_ExistingTaxDeclarationStatus | N                              |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_isDeceased  | false         |
            | RAS_applicant_applicantId | {applicantId} |

    @happyPath @TestCaseKey=CAO-T928
    Scenario: IPC Check Eligibility service for customer with FATCA Question not available selfCertDeclaration with value X: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1251111111"
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
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                   | true                           |
            | RAS_application_statusCode                             | InProgress                     |
            | RAS_application_statusReason                           | Applicant eligible for account |
            | RAS_application_applicant_ExistingTaxDeclarationStatus | X                              |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_isDeceased  | false         |
            | RAS_applicant_applicantId | {applicantId} |
 
    # *******************************************************************
    #           ########  ERROR SCENARIOS   ##########
    # *******************************************************************

    #********************************************************************
    #   Pre-Checks for customer who is Dead
    # *******************************************************************

    @eligibilityFailure @TestCaseKey=CAO-T569
    Scenario: IPC Check Eligibility service for Deceased status is "1":HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1291111111"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                               |
            | Response_eligibility_errorCode    | 120                                 |
            | Response_eligibility_errorMessage | CIS indicating customer is deceased |
            | Response_code                     | 200                                 |
            | Response_type                     | BusinessException                   |
            | Response_retry                    | false                               |
            | Response_message                  | Eligibility check failed            |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                               |
            | RAS_application_statusCode               | Terminated                          |
            | RAS_application_statusReason             | Applicant not eligible for account  |
            | RAS_application_eligibility_errorCode    | 120                                 |
            | RAS_application_eligibility_errorMessage | CIS indicating customer is deceased |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T570   
    Scenario: IPC Check Eligibility service for Deceased status is "5":HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1291111112"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                               |
            | Response_eligibility_errorCode    | 120                                 |
            | Response_eligibility_errorMessage | CIS indicating customer is deceased |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                               |
            | RAS_application_statusCode               | Terminated                          |
            | RAS_application_statusReason             | Applicant not eligible for account  |
            | RAS_application_eligibility_errorCode    | 120                                 |
            | RAS_application_eligibility_errorMessage | CIS indicating customer is deceased |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T571
    Scenario: IPC Check Eligibility service for Deceased status is "6":HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1291111113"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                               |
            | Response_eligibility_errorCode    | 120                                 |
            | Response_eligibility_errorMessage | CIS indicating customer is deceased |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                               |
            | RAS_application_statusCode               | Terminated                          |
            | RAS_application_statusReason             | Applicant not eligible for account  |
            | RAS_application_eligibility_errorCode    | 120                                 |
            | RAS_application_eligibility_errorMessage | CIS indicating customer is deceased |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    #********************************************************************
    #   Pre-Checks for customer who is NoTrace
    # *******************************************************************

    @eligibilityFailure @TestCaseKey=CAO-T572   
    Scenario: IPC Check Eligibility service for ownerNoTraceIndicator is true and contactPointUnavailableReason is 1:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1321111112"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                      |
            | Response_eligibility_errorCode    | 130                                        |
            | Response_eligibility_errorMessage | CIS indicating customer is set as No Trace |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                      |
            | RAS_application_statusCode               | Terminated                                 |
            | RAS_application_statusReason             | Applicant not eligible for account         |
            | RAS_application_eligibility_errorCode    | 130                                        |
            | RAS_application_eligibility_errorMessage | CIS indicating customer is set as No Trace |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T1048
    Scenario: IPC Check Eligibility service for ownerNoTraceIndicator is true and contactPointUnavailableReason is 2:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111144"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                      |
            | Response_eligibility_errorCode    | 130                                        |
            | Response_eligibility_errorMessage | CIS indicating customer is set as No Trace |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                      |
            | RAS_application_statusCode               | Terminated                                 |
            | RAS_application_statusReason             | Applicant not eligible for account         |
            | RAS_application_eligibility_errorCode    | 130                                        |
            | RAS_application_eligibility_errorMessage | CIS indicating customer is set as No Trace |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T1049
    Scenario: IPC Check Eligibility service for ownerNoTraceIndicator is true and contactPointUnavailableReason is 3:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111145"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                      |
            | Response_eligibility_errorCode    | 130                                        |
            | Response_eligibility_errorMessage | CIS indicating customer is set as No Trace |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                      |
            | RAS_application_statusCode               | Terminated                                 |
            | RAS_application_statusReason             | Applicant not eligible for account         |
            | RAS_application_eligibility_errorCode    | 130                                        |
            | RAS_application_eligibility_errorMessage | CIS indicating customer is set as No Trace |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T1050
    Scenario: IPC Check Eligibility service for ownerNoTraceIndicator is true and contactPointUnavailableReason is 4:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111146"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                      |
            | Response_eligibility_errorCode    | 130                                        |
            | Response_eligibility_errorMessage | CIS indicating customer is set as No Trace |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                      |
            | RAS_application_statusCode               | Terminated                                 |
            | RAS_application_statusReason             | Applicant not eligible for account         |
            | RAS_application_eligibility_errorCode    | 130                                        |
            | RAS_application_eligibility_errorMessage | CIS indicating customer is set as No Trace |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    # ********************************************************************************************************
    #   Pre-Checks for customer details - firstname, Lastname & country Code
    # *******************************************************************************************************

    @eligibilityFailure @TestCaseKey=CAO-T730
    Scenario: IPC Check Eligibility service for Country code not GB:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1361111111"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                    |
            | Response_eligibility_errorCode    | 100                                                                      |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Country is not UK |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                    |
            | RAS_application_statusCode               | Terminated                                                               |
            | RAS_application_statusReason             | Applicant not eligible for account                                       |
            | RAS_application_eligibility_errorCode    | 100                                                                      |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Country is not UK |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T736
    Scenario: IPC Check Eligibility service for Firstname not available:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1001111111"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                                         |
            | Response_eligibility_errorCode    | 100                                                                                           |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - First name or Last name  not provided. |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                                         |
            | RAS_application_statusCode               | Terminated                                                                                    |
            | RAS_application_statusReason             | Applicant not eligible for account                                                            |
            | RAS_application_eligibility_errorCode    | 100                                                                                           |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - First name or Last name  not provided. |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T737
    Scenario: IPC Check Eligibility service for Lastname not available:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1021111111"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                                         |
            | Response_eligibility_errorCode    | 100                                                                                           |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - First name or Last name  not provided. |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                                         |
            | RAS_application_statusCode               | Terminated                                                                                    |
            | RAS_application_statusReason             | Applicant not eligible for account                                                            |
            | RAS_application_eligibility_errorCode    | 100                                                                                           |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - First name or Last name  not provided. |  
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T738
    Scenario: IPC Check Eligibility service for Firstname and Lastname not available:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1051111111"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                                         |
            | Response_eligibility_errorCode    | 100                                                                                           |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - First name or Last name  not provided. |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                                         |
            | RAS_application_statusCode               | Terminated                                                                                    |
            | RAS_application_statusReason             | Applicant not eligible for account                                                            |
            | RAS_application_eligibility_errorCode    | 100                                                                                           |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - First name or Last name  not provided. |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    #********************************************************************************************************
    #   Pre-Checks for customer mobile
    # *******************************************************************************************************

    @eligibilityFailure @TestCaseKey=CAO-T726
    Scenario: IPC Check Eligibility service for mobile number not available:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1081111111"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                                |
            | Response_eligibility_errorCode    | 100                                                                                  |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Mobile Number is not provided |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                                |
            | RAS_application_statusCode               | Terminated                                                                           |
            | RAS_application_statusReason             | Applicant not eligible for account                                                   |
            | RAS_application_isOwnerTraceable         | true                                                                                 |
            | RAS_application_eligibility_errorCode    | 100                                                                                  |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Mobile Number is not provided |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId                     | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T802
    Scenario: IPC Check Eligibility service for invalid mobile number starting with 09:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111135"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                                |
            | Response_eligibility_errorCode    | 100                                                                                  |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Mobile Number is not provided |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                                |
            | RAS_application_statusCode               | Terminated                                                                           |
            | RAS_application_statusReason             | Applicant not eligible for account                                                   |
            | RAS_application_isOwnerTraceable         | true                                                                                 |
            | RAS_application_eligibility_errorCode    | 100                                                                                  |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Mobile Number is not provided |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId                     | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T803
    Scenario: IPC Check Eligibility service for invalid mobile number starting with 6:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111134"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                                |
            | Response_eligibility_errorCode    | 100                                                                                  |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Mobile Number is not provided |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                                |
            | RAS_application_statusCode               | Terminated                                                                           |
            | RAS_application_statusReason             | Applicant not eligible for account                                                   |
            | RAS_application_isOwnerTraceable         | true                                                                                 |
            | RAS_application_eligibility_errorCode    | 100                                                                                  |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Mobile Number is not provided |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId                     | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T743
    Scenario: IPC Check Eligibility service for Invalid mobile number:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1341111111"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                             |
            | Response_eligibility_errorCode    | 100                                                                               |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Mobile Number is not valid |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                             |
            | RAS_application_statusCode               | Terminated                                                                        |
            | RAS_application_statusReason             | Applicant not eligible for account                                                |
            | RAS_application_isOwnerTraceable         | true                                                                              |
            | RAS_application_eligibility_errorCode    | 100                                                                               |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Mobile Number is not valid |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId                     | {applicantId} |

    # #********************************************************************************************************
    #   Pre-Checks for customer email address
    # *******************************************************************************************************

    @eligibilityFailure @TestCaseKey=CAO-T734
    Scenario: IPC Check Eligibility service for email Id with empty string:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111119"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                           |
            | Response_eligibility_errorCode    | 100                                                                             |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Email Address is missing |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                           |
            | RAS_application_statusCode               | Terminated                                                                      |
            | RAS_application_statusReason             | Applicant not eligible for account                                              |
            | RAS_application_isOwnerTraceable         | true                                                                            |
            | RAS_application_eligibility_errorCode    | 100                                                                             |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Email Address is missing |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId              | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T729
    Scenario: IPC Check Eligibility service for Invalid email Id:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1331111111"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                             |
            | Response_eligibility_errorCode    | 100                                                                               |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Email Address is not valid |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                             |
            | RAS_application_statusCode               | Terminated                                                                        |
            | RAS_application_statusReason             | Applicant not eligible for account                                                |
            | RAS_application_eligibility_errorCode    | 100                                                                               |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Email Address is not valid |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId              | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T727
    Scenario: IPC Check Eligibility service for Email address not available:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1071111111"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                           |
            | Response_eligibility_errorCode    | 100                                                                             |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Email Address is missing |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                           |
            | RAS_application_statusCode               | Terminated                                                                      |
            | RAS_application_statusReason             | Applicant not eligible for account                                              |
            | RAS_application_eligibility_errorCode    | 100                                                                             |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Email Address is missing |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId              | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T749
    Scenario: IPC Check Eligibility service for Invalid email Id with wrong email domain address:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111117"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                             |
            | Response_eligibility_errorCode    | 100                                                                               |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Email Address is not valid |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                             |
            | RAS_application_statusCode               | Terminated                                                                        |
            | RAS_application_statusReason             | Applicant not eligible for account                                                |
            | RAS_application_eligibility_errorCode    | 100                                                                               |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Email Address is not valid |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId              | {applicantId}  |

    @eligibilityFailure @TestCaseKey=CAO-T754
    Scenario: IPC Check Eligibility service for Invalid email Id with wrong domain format:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111114"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                             |
            | Response_eligibility_errorCode    | 100                                                                               |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Email Address is not valid |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                             |
            | RAS_application_statusCode               | Terminated                                                                        |
            | RAS_application_statusReason             | Applicant not eligible for account                                                |
            | RAS_application_eligibility_errorCode    | 100                                                                               |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Email Address is not valid |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId              | {applicantId}            |

    @eligibilityFailure @TestCaseKey=CAO-T755
    Scenario: IPC Check Eligibility service for Invalid email Id with wrong email prefix:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111116"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                             |
            | Response_eligibility_errorCode    | 100                                                                               |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Email Address is not valid |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                             |
            | RAS_application_statusCode               | Terminated                                                                        |
            | RAS_application_statusReason             | Applicant not eligible for account                                                |
            | RAS_application_eligibility_errorCode    | 100                                                                               |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Email Address is not valid |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId              | {applicantId}      |

    # ********************************************************************************************************
    #   Pre-Checks for customer ID status
    # *******************************************************************************************************

    @eligibilityFailure @TestCaseKey=CAO-T728
    Scenario: IPC Check Eligibility service for IDStatus value is anything other than "0001":HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1271111111"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                        |
            | Response_eligibility_errorCode    | 110                          |
            | Response_eligibility_errorMessage | Customer is not ID Confirmed |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount       | false                              |
            | RAS_application_statusCode                 | Terminated                         |
            | RAS_application_statusReason               | Applicant not eligible for account |
            | RAS_application_eligibility_errorCode      | 110                                |
            | RAS_application_eligibility_errorMessage   | Customer is not ID Confirmed       |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T756
    Scenario: IPC Check Eligibility service for IDstatus value is null:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111121"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                        |
            | Response_eligibility_errorCode    | 110                          |
            | Response_eligibility_errorMessage | Customer is not ID Confirmed |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount       | false                              |
            | RAS_application_statusCode                 | Terminated                         |
            | RAS_application_statusReason               | Applicant not eligible for account |
            | RAS_application_eligibility_errorCode      | 110                                |
            | RAS_application_eligibility_errorMessage   | Customer is not ID Confirmed       |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T735
    Scenario: IPC Check Eligibility service for ID status value is empty:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111120"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                        |
            | Response_eligibility_errorCode    | 110                          |
            | Response_eligibility_errorMessage | Customer is not ID Confirmed |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount       | false                              |
            | RAS_application_statusCode                 | Terminated                         |
            | RAS_application_statusReason               | Applicant not eligible for account |
            | RAS_application_eligibility_errorCode      | 110                                |
            | RAS_application_eligibility_errorMessage   | Customer is not ID Confirmed       |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T1051
    Scenario: IPC Check Eligibility service for ID status value is 3:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111143"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId | global | Request_eligibility_applicantId |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                   |
            | Response_eligibility_errorCode    | 115                     |
            | Response_eligibility_errorMessage | Customer is ID Declined |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                              |
            | RAS_application_statusCode               | Terminated                         |
            | RAS_application_statusReason             | Applicant not eligible for account |
            | RAS_application_eligibility_errorCode    | 115                                |
            | RAS_application_eligibility_errorMessage | Customer is ID Declined            |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    #********************************************************************************************************
    #   Pre-Checks for Customer Address
    # *******************************************************************************************************

    @eligibilityFailure @TestCaseKey=CAO-T731
    Scenario: IPC Check Eligibility service for Invalid BFPO Address:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1411111114"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                                               |
            | Response_eligibility_errorCode    | 100                                                                                                 |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - AddressLine1 or AddressLine2 is not provided |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                                               |
            | RAS_application_statusCode               | Terminated                                                                                          |
            | RAS_application_statusReason             | Applicant not eligible for account                                                                  |
            | RAS_application_eligibility_errorCode    | 100                                                                                                 |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - AddressLine1 or AddressLine2 is not provided |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId                  | {applicantId}        |

    @eligibilityFailure @TestCaseKey=CAO-T732
    Scenario: IPC Check Eligibility service for BFPONumber is empty:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1411111116"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                                   |
            | Response_eligibility_errorCode    | 100                                                                                     |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - BFPO or Postcode is not provided |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                                   |
            | RAS_application_statusCode               | Terminated                                                                              |
            | RAS_application_statusReason             | Applicant not eligible for account                                                      |
            | RAS_application_eligibility_errorCode    | 100                                                                                     |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - BFPO or Postcode is not provided |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId        | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T733
    Scenario: IPC Check Eligibility service for Postal Address Not Available:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1101111111"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                                   |
            | Response_eligibility_errorCode    | 100                                                                                     |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - BFPO or Postcode is not provided |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                                   |
            | RAS_application_statusCode               | Terminated                                                                              |
            | RAS_application_statusReason             | Applicant not eligible for account                                                      |
            | RAS_application_eligibility_errorCode    | 100                                                                                     |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - BFPO or Postcode is not provided |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T804
    Scenario: IPC Check Eligibility service for buildingNumber value is null:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111132"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                                                   |
            | Response_eligibility_errorCode    | 100                                                                                                     |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Building Name or Building Number is not provided |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                                                   |
            | RAS_application_statusCode               | Terminated                                                                                              |
            | RAS_application_statusReason             | Applicant not eligible for account                                                                      |
            | RAS_application_eligibility_errorCode    | 100                                                                                                     |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Building Name or Building Number is not provided |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T806
    Scenario: IPC Check Eligibility service for thoroughfareName value is null:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111129"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                               |
            | Response_eligibility_errorCode    | 100                                                                                 |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Thoroughfare is not provided |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                               |
            | RAS_application_statusCode               | Terminated                                                                          |
            | RAS_application_statusReason             | Applicant not eligible for account                                                  |
            | RAS_application_eligibility_errorCode    | 100                                                                                 |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Thoroughfare is not provided |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId            | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T807
    Scenario: IPC Check Eligibility service for city value is null:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111128"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                       |
            | Response_eligibility_errorCode    | 100                                                                         |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - City is not provided |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                       |
            | RAS_application_statusCode               | Terminated                                                                  |
            | RAS_application_statusReason             | Applicant not eligible for account                                          |
            | RAS_application_eligibility_errorCode    | 100                                                                         |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - City is not provided |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId        | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T808
    Scenario: IPC Check Eligibility service for buildingNumber value is empty:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111126"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                                                   |
            | Response_eligibility_errorCode    | 100                                                                                                     |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Building Name or Building Number is not provided |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                                                   |
            | RAS_application_statusCode               | Terminated                                                                                              |
            | RAS_application_statusReason             | Applicant not eligible for account                                                                      |
            | RAS_application_eligibility_errorCode    | 100                                                                                                     |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Building Name or Building Number is not provided |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId               | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T810
    Scenario: IPC Check Eligibility service for thoroughfareName value is empty:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111124"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                               |
            | Response_eligibility_errorCode    | 100                                                                                 |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Thoroughfare is not provided |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                               |
            | RAS_application_statusCode               | Terminated                                                                          |
            | RAS_application_statusReason             | Applicant not eligible for account                                                  |
            | RAS_application_eligibility_errorCode    | 100                                                                                 |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Thoroughfare is not provided |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId            | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T811
    Scenario: IPC Check Eligibility service for city value is empty:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111123"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                       |
            | Response_eligibility_errorCode    | 100                                                                         |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - City is not provided |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                       |
            | RAS_application_statusCode               | Terminated                                                                  |
            | RAS_application_statusReason             | Applicant not eligible for account                                          |
            | RAS_application_eligibility_errorCode    | 100                                                                         |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - City is not provided |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId        | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T812
    Scenario: IPC Check Eligibility service for buildingName value is empty:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111122"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                                                   |
            | Response_eligibility_errorCode    | 100                                                                                                     |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Building Name or Building Number is not provided |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                                                   |
            | RAS_application_statusCode               | Terminated                                                                                              |
            | RAS_application_statusReason             | Applicant not eligible for account                                                                      |
            | RAS_application_eligibility_errorCode    | 100                                                                                                     |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Building Name or Building Number is not provided |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId          | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T750   
    Scenario: IPC Check Eligibility service for BFPONumber is null:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1411111115"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                                   |
            | Response_eligibility_errorCode    | 100                                                                                     |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - BFPO or Postcode is not provided |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                                   |
            | RAS_application_statusCode               | Terminated                                                                              |
            | RAS_application_statusReason             | Applicant not eligible for account                                                      |
            | RAS_application_eligibility_errorCode    | 100                                                                                     |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - BFPO or Postcode is not provided |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId        | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T751   
    Scenario: IPC Check Eligibility service for BFPO address lines are empty:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1411111118"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                                               |
            | Response_eligibility_errorCode    | 100                                                                                                 |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - AddressLine1 or AddressLine2 is not provided |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                                               |
            | RAS_application_statusCode               | Terminated                                                                                          |
            | RAS_application_statusReason             | Applicant not eligible for account                                                                  |
            | RAS_application_eligibility_errorCode    | 100                                                                                                 |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - AddressLine1 or AddressLine2 is not provided |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T752
    Scenario: IPC Check Eligibility service for BFPO address lines are null:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1411111119"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                                               |
            | Response_eligibility_errorCode    | 100                                                                                                 |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - AddressLine1 or AddressLine2 is not provided |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                                               |
            | RAS_application_statusCode               | Terminated                                                                                          |
            | RAS_application_statusReason             | Applicant not eligible for account                                                                  |
            | RAS_application_eligibility_errorCode    | 100                                                                                                 |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - AddressLine1 or AddressLine2 is not provided |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T753
    Scenario: IPC Check Eligibility service for BFPO address with country field is null:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111111"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                    |
            | Response_eligibility_errorCode    | 100                                                                      |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Country is not UK |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                    |
            | RAS_application_statusCode               | Terminated                                                               |
            | RAS_application_statusReason             | Applicant not eligible for account                                       |
            | RAS_application_eligibility_errorCode    | 100                                                                      |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Country is not UK |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId     | {applicantId} |

    #********************************************************************
    #   Pre-Checks: Postal code
    # *******************************************************************
    
    @eligibilityFailure @TestCaseKey=CAO-T805
    Scenario: IPC Check Eligibility service for postalCode value is null:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111131"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                                   |
            | Response_eligibility_errorCode    | 100                                                                                     |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - BFPO or Postcode is not provided |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                                   |
            | RAS_application_statusCode               | Terminated                                                                              |
            | RAS_application_statusReason             | Applicant not eligible for account                                                      |
            | RAS_application_eligibility_errorCode    | 100                                                                                     |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - BFPO or Postcode is not provided |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId      | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T809
    Scenario: IPC Check Eligibility service for postalCode value is empty:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111125"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                                   |
            | Response_eligibility_errorCode    | 100                                                                                     |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - BFPO or Postcode is not provided |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                                   |
            | RAS_application_statusCode               | Terminated                                                                              |
            | RAS_application_statusReason             | Applicant not eligible for account                                                      |
            | RAS_application_eligibility_errorCode    | 100                                                                                     |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - BFPO or Postcode is not provided |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId      | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T1052
    Scenario: IPC Check Eligibility service for postal code ending with number:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111153"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                                   |
            | Response_eligibility_errorCode    | 100                                                                                     |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Postcode is in invalid format |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                                   |
            | RAS_application_statusCode               | Terminated                                                                              |
            | RAS_application_statusReason             | Applicant not eligible for account                                                      |
            | RAS_application_eligibility_errorCode    | 100                                                                                     |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Postcode is in invalid format |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId      | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T1053
    Scenario: IPC Check Eligibility service for postal code starting with number:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111154"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                                   |
            | Response_eligibility_errorCode    | 100                                                                                     |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Postcode is in invalid format |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                                   |
            | RAS_application_statusCode               | Terminated                                                                              |
            | RAS_application_statusReason             | Applicant not eligible for account                                                      |
            | RAS_application_eligibility_errorCode    | 100                                                                                     |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Postcode is in invalid format |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId      | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T1054
    Scenario: IPC Check Eligibility service for postal code with numbers:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111155"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                                   |
            | Response_eligibility_errorCode    | 100                                                                                     |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Postcode is in invalid format |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                                   |
            | RAS_application_statusCode               | Terminated                                                                              |
            | RAS_application_statusReason             | Applicant not eligible for account                                                      |
            | RAS_application_eligibility_errorCode    | 100                                                                                     |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Postcode is in invalid format |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId      | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T1055
    Scenario: IPC Check Eligibility service for postal code with alphabets:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111156"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                                   |
            | Response_eligibility_errorCode    | 100                                                                                     |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Postcode is in invalid format |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                                   |
            | RAS_application_statusCode               | Terminated                                                                              |
            | RAS_application_statusReason             | Applicant not eligible for account                                                      |
            | RAS_application_eligibility_errorCode    | 100                                                                                     |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Postcode is in invalid format |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId      | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T1056
    Scenario: IPC Check Eligibility service for postal code with spacial character:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111157"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_eligibility_applicantRevision   |
            | applicationRevision | global | Request_eligibility_applicationRevision |
            | applicantId         | global | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                                                                   |
            | Response_eligibility_errorCode    | 100                                                                                     |
            | Response_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Postcode is in invalid format |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                                                                   |
            | RAS_application_statusCode               | Terminated                                                                              |
            | RAS_application_statusReason             | Applicant not eligible for account                                                      |
            | RAS_application_eligibility_errorCode    | 100                                                                                     |
            | RAS_application_eligibility_errorMessage | Customer details held on CIS incomplete or incorrect - Postcode is in invalid format |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId      | {applicantId} |

    #********************************************************************
    #   Pre-Checks: Double check account belongs to customer
    # *******************************************************************

    @eligibilityFailure @TestCaseKey=CAO-T740
    Scenario: IPC Check Eligibility service for account not belongs to customer:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111122"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 100045   | Request_eligibility_sortCode            |
            | accountNumber       | 12345678 | Request_eligibility_accountNo           |
            | applicantRevision   | global   | Request_eligibility_applicantRevision   |
            | applicationRevision | global   | Request_eligibility_applicationRevision |
            | applicantId         | global   | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                          |
            | Response_eligibility_errorCode    | 200                                            |
            | Response_eligibility_errorMessage | Account number does not belong to the customer |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                          |
            | RAS_application_statusCode               | Terminated                                     |
            | RAS_application_statusReason             | Applicant not eligible for account             |
            | RAS_application_eligibility_errorCode    | 200                                            |
            | RAS_application_eligibility_errorMessage | Account number does not belong to the customer |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |

    @eligibilityFailure @TestCaseKey=CAO-T741
    Scenario: IPC Check Eligibility service for account belongs to customer but not valid account type:HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111122"
        And I verify the response status code as "200"
        Given I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        Given I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"
        Then I call POST method for CreateApplication with the headers and request body
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        Given I prepare the "CheckEligibility" payload details
        Given I set "PUT" method for "CheckEligibility"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | sortCode            | 123456  | Request_eligibility_sortCode            |
            | accountNumber       | 12321126 | Request_eligibility_accountNo           |
            | applicantRevision   | global  | Request_eligibility_applicantRevision   |
            | applicationRevision | global  | Request_eligibility_applicationRevision |
            | applicantId         | global  | Request_eligibility_applicantId         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_eligibility_isEligible   | false                                          |
            | Response_eligibility_errorCode    | 200                                            |
            | Response_eligibility_errorMessage | Account number does not belong to the customer |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | false                                          |
            | RAS_application_statusCode               | Terminated                                     |
            | RAS_application_statusReason             | Applicant not eligible for account             |
            | RAS_application_eligibility_errorCode    | 200                                            |
            | RAS_application_eligibility_errorMessage | Account number does not belong to the customer |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId} |