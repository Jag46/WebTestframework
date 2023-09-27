@api @ipc @regression
Feature: Scenarios for the IPC service update terms and conditions end point

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

    @happyPath  @TestCaseKey=CAO-T1085
    Scenario: IPC Update Terms and Conditions end point for all 5 signed documents for customer with OD: HTTP 200
        Given I set "PUT" method for "IPC_TermsAndConditions"
        And I set the "IPC_TermsAndConditionsWithOD" request body
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | appId               | global | Request_appId               |
            | applicantId         | global | Request_applicantId         |
            | applicationRevision | global | Request_applicationRevision |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the complete response body should be "PutTermsAndConditions"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the number of "responsePayload.applicants[0].signedTerms" returned are "equals" to "5"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_signedTerms1_productId    | 7006                           |
            | RAS_application_signedTerms1_version      | default                        |
            | RAS_application_signedTerms1_documentType | Fscs                           |
            | RAS_application_signedTerms2_version      | P857 (November 2019)           |
            | RAS_application_signedTerms2_documentType | TnC                            |
            | RAS_application_signedTerms3_version      | P7430 (July 2020)              |
            | RAS_application_signedTerms3_documentType | RatesAndCharges                |
            | RAS_application_signedTerms4_version      | FDOM01_EDB                     |
            | RAS_application_signedTerms4_documentType | OverdraftAgreement             |
            | RAS_application_signedTerms5_version      | PCI_7006 (November 2019) - EDB |
            | RAS_application_signedTerms5_documentType | Pcci                           |
        And I verify the following param value is "api_exist" with response param value
            | RAS_application_signedTerms1_signedOn | currentDate |

    @happyPath  @TestCaseKey=CAO-T1086
    Scenario: IPC Update Terms and Conditions service for 3 signed documents for a customer without OD:HTTP 400
        Given I set "PUT" method for "IPC_TermsAndConditions"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "IPC_TermsAndConditionsWithoutOD" request body
        And I modify the following param values in the current request body
            | appId               | global | Request_appId               |
            | applicantId         | global | Request_applicantId         |
            | applicationRevision | global | Request_applicationRevision |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the complete response body should be "PutTermsAndConditions"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the number of "responsePayload.applicants[0].signedTerms" returned are "equals" to "3"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_signedTerms1_productId    | 7006                 |
            | RAS_application_signedTerms1_version      | default              |
            | RAS_application_signedTerms1_documentType | Fscs                 |
            | RAS_application_signedTerms2_version      | P857 (November 2019) |
            | RAS_application_signedTerms2_documentType | TnC                  |
            | RAS_application_signedTerms3_version      | P7430 (July 2020)    |
            | RAS_application_signedTerms3_documentType | RatesAndCharges      |
        And I verify the following param value is "api_exist" with response param value
            | RAS_application_signedTerms1_signedOn | currentDate |

    # **********************************************************************
    #             ERROR SCENARIOS for Headers, Path parameter validation
    # **********************************************************************

    @error  @TestCaseKey=CAO-T1087  @400
    Scenario: IPC Update Terms and Conditions service when invalid app id is provided in path parameter:HTTP 400
        Given I "update" the following global values
            | appId | hfysdgfsd |
        And I set "PUT" method for "IPC_TermsAndConditions"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "IPC_TermsAndConditionsWithoutOD" request body
        And I modify the following param values in the current request body
            | appId               | global | Request_appId               |
            | applicantId         | global | Request_applicantId         |
            | applicationRevision | global | Request_applicationRevision |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the complete response body should be "InvalidAppId"

    @error  @TestCaseKey=CAO-T1088  @400
    Scenario: IPC Update Terms and Conditions service when invalid x-journey Id is provided:HTTP 400
        Given I set "PUT" method for "IPC_TermsAndConditions"
        And I set the config for the request to "default"
        And I "update" the following global values
            | x-journey-id | hfysdgfsd |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "IPC_TermsAndConditionsWithoutOD" request body
        And I modify the following param values in the current request body
            | appId               | global | Request_appId               |
            | applicantId         | global | Request_applicantId         |
            | applicationRevision | global | Request_applicationRevision |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the complete response body should be "InvalidxjourneyId"

    @error  @TestCaseKey=CAO-T1089  @400
    Scenario: IPC Update Terms and Conditions service when x-journey-Id is not provided in the header:HTTP 400
        Given I set "PUT" method for "IPC_TermsAndConditions"
        And I set the config for the request to "default"
        And I set the headers for the request
            | Authorization |  |
        And I set the "IPC_TermsAndConditionsWithoutOD" request body
        And I modify the following param values in the current request body
            | appId               | global | Request_appId               |
            | applicantId         | global | Request_applicantId         |
            | applicationRevision | global | Request_applicationRevision |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the complete response body should be "MissingxjourneyId"

    @error  @TestCaseKey=CAO-T1090  @401
    Scenario: IPC Update Terms and Conditions service when invalid Authorization is provided:HTTP 401
        Given I set "PUT" method for "IPC_TermsAndConditions"
        And I set the config for the request to "default"
        And I "update" the following global values
            | jwt | hfysdgfsd |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "IPC_TermsAndConditionsWithoutOD" request body
        And I modify the following param values in the current request body
            | appId               | global | Request_appId               |
            | applicantId         | global | Request_applicantId         |
            | applicationRevision | global | Request_applicationRevision |
        When I send the request
        Then I verify the response status code as "401"
        And I verify the complete response body should be "Unauthorized"

    @error  @TestCaseKey=CAO-T1091  @401
    Scenario: IPC Update Terms and Conditions service when Authorization is not provided in the header:HTTP 401
        Given I set "PUT" method for "IPC_TermsAndConditions"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id |  |
        And I set the "IPC_TermsAndConditionsWithoutOD" request body
        And I modify the following param values in the current request body
            | appId               | global | Request_appId               |
            | applicantId         | global | Request_applicantId         |
            | applicationRevision | global | Request_applicationRevision |
        When I send the request
        Then I verify the response status code as "401"
        And I verify the complete response body should be "Unauthorized"

    # **********************************************************************
    #             ERROR SCENARIOS for Request Body field level validation
    # **********************************************************************

    @error  @400   @TestCaseKey=CAO-T1115  @TestCaseKey=CAO-T1123   @TestCaseKey=CAO-T1124  @TestCaseKey=CAO-T1125  @TestCaseKey=CAO-T1126
    Scenario Outline: IPC Update Terms and Conditions service when <fieldName> is not provided:HTTP 400
        Given I set "PUT" method for "IPC_TermsAndConditions"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "IPC_TermsAndConditionsWithoutOD" request body
        And I modify the following param values in the current request body
            | appId               | global | Request_appId               |
            | applicantId         | global | Request_applicantId         |
            | applicationRevision | global | Request_applicationRevision |
            | <fieldName>         | remove | <path>                      |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400               |
            | Response_error_type    | BusinessException |
            | Response_error_retry   | false             |
            | Response_error_message | <errorMessage>    |
        Examples:
            | fieldName           | path                        | errorMessage                           |
            | appId               | Request_appId               | Missing AppId in request               |
            | applicantId         | Request_applicantId         | Missing ApplicantId in request         |
            | applicationRevision | Request_applicationRevision | Missing ApplicationRevision in request |
            | productId           | terms[0].productId          | Missing ProductId in request           |
            | documentType        | terms[0].documentType       | Missing DocumentType in request        |

    @error  @400   @TestCaseKey=CAO-T1127   @TestCaseKey=CAO-T1128  @TestCaseKey=CAO-T1129  @TestCaseKey=CAO-T1130  @TestCaseKey=CAO-T1131
    Scenario Outline: IPC Update Terms and Conditions service when invalid <fieldName> is provided:HTTP 400
        Given I set "PUT" method for "IPC_TermsAndConditions"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "IPC_TermsAndConditionsWithoutOD" request body
        And I modify the following param values in the current request body
            | appId               | global | Request_appId               |
            | applicantId         | global | Request_applicantId         |
            | applicationRevision | global | Request_applicationRevision |
            | <fieldName>         | 1234   | <path>                      |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400               |
            | Response_error_type    | BusinessException |
            | Response_error_retry   | false             |
            | Response_error_message | <errorMessage>    |
        Examples:
            | fieldName           | path                        | errorMessage                                  |
            | appId               | Request_appId               | Valid AppId required in request               |
            | applicantId         | Request_applicantId         | Valid ApplicantId required in request         |
            | applicationRevision | Request_applicationRevision | Valid ApplicationRevision required in request |
            | productId           | terms[0].productId          | Invalid request                               |
            | documentType        | terms[0].documentType       | Invalid request                               |