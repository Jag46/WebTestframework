@regression @ipc @api
Feature: Scenarios for the IPC Service Update Account data to the AppStore end point

    Background: Generate JWT for use in token handler calls and create application
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1234567890"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number "12345678" and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"
        And I call POST method for CreateApplication with the headers and request body
        And I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"

    # *************************************************
    #           HAPPY PATH SCENARIOS
    # *************************************************

    @TestCaseKey=CAO-T993 @PutAccountData
    Scenario: IPC /customer/account call to AppStore to save Chequebook and all Marketing Prefs to true - HTTP 200
        Given I set "PUT" method for "IPC_AccountData"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | global |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "IPC_PutAccountData" request body
        And I modify the following param values in the current request body
            | applicantRevision   | global | updateMarketingPreferencesRequest.applicantRevision |
            | applicantId         | global | updateMarketingPreferencesRequest.applicantId       |
            | applicationRevision | global | updateChequebookRequest.applicationRevision         |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the complete response body should be "PutAccountData"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_applicant_preferences_isChequebookRequired | true |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_marketingPref_isEmailPreferred                | true |
            | RAS_applicant_marketingPref_isPhonePreferred                | true |
            | RAS_applicant_marketingPref_isMailPreferred                 | true |
            | RAS_applicant_marketingPref_UpdateMarketingPreferencesOnCIS | true |

    @TestCaseKey=CAO-T994 @PutAccountData
    Scenario: IPC /customer/account call to AppStore to save Chequebook and all Marketing Prefs to false - HTTP 200
        Given I set "PUT" method for "IPC_AccountData"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | global |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "IPC_PutAccountData" request body
        And I modify the following param values in the current request body
            | applicantRevision    | global | updateMarketingPreferencesRequest.applicantRevision               |
            | applicantId          | global | updateMarketingPreferencesRequest.applicantId                     |
            | applicationRevision  | global | updateChequebookRequest.applicationRevision                       |
            | isEmailPreferred     | false  | updateMarketingPreferencesRequest.isEmailPreferred                |
            | isMailPreferred      | false  | updateMarketingPreferencesRequest.isMailPreferred                 |
            | isPhonePreferred     | false  | updateMarketingPreferencesRequest.isPhonePreferred                |
            | isChequeBookRequired | false  | updateChequebookRequest.applicantPreferences.isChequeBookRequired |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the complete response body should be "PutAccountData"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_applicant_preferences_isChequebookRequired | false |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_marketingPref_isEmailPreferred                | false |
            | RAS_applicant_marketingPref_isPhonePreferred                | false |
            | RAS_applicant_marketingPref_isMailPreferred                 | false |
            | RAS_applicant_marketingPref_UpdateMarketingPreferencesOnCIS | true  |

    @TestCaseKey=CAO-T995 @PutAccountData
    Scenario: IPC /customer/account call to AppStore to save Chequebook and all Marketing Prefs with varied values - HTTP 200
        Given I set "PUT" method for "IPC_AccountData"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | global |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "IPC_PutAccountData" request body
        And I modify the following param values in the current request body
            | applicantRevision    | global | updateMarketingPreferencesRequest.applicantRevision               |
            | applicantId          | global | updateMarketingPreferencesRequest.applicantId                     |
            | applicationRevision  | global | updateChequebookRequest.applicationRevision                       |
            | isEmailPreferred     | false  | updateMarketingPreferencesRequest.isEmailPreferred                |
            | isMailPreferred      | remove | updateMarketingPreferencesRequest.isMailPreferred                 |
            | isPhonePreferred     | false  | updateMarketingPreferencesRequest.isPhonePreferred                |
            | isChequeBookRequired | remove | updateChequebookRequest.applicantPreferences.isChequeBookRequired |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the complete response body should be "PutAccountData"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_applicant_preferences_isChequebookRequired | false |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_marketingPref_isEmailPreferred                | false |
            | RAS_applicant_marketingPref_isPhonePreferred                | false |
            | RAS_applicant_marketingPref_isMailPreferred                 | null  |
            | RAS_applicant_marketingPref_UpdateMarketingPreferencesOnCIS | true  |

    @TestCaseKey=CAO-T1132 @PutAccountData
    Scenario: IPC /customer/account call to AppStore to save Chequebook but no Marketing Prefs in request  - HTTP 200
        Given I set "PUT" method for "IPC_AccountData"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | global |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "IPC_PutAccountData" request body
        And I modify the following param values in the current request body
            | updateMarketingPreferencesRequest | remove     | updateMarketingPreferencesRequest                                 |
            | applicationRevision               | global     | updateChequebookRequest.applicationRevision                       |
            | isChequeBookRequired              | remove     | updateChequebookRequest.applicantPreferences.isChequeBookRequired |
            | cardType                          | VISA DEBIT | updateChequebookRequest.applicantPreferences.cardType             |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the complete response body should be "PutAccountDataNoMarketingPrefs"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_applicant_preferences_isChequebookRequired | false      |
            | RAS_application_applicant_preferences_cardType             | VISA DEBIT |


    # *************************************************
    #           ERROR SCENARIOS
    # *************************************************

    @TestCaseKey=CAO-T996 @PutAccountData @error @400
    Scenario: IPC /customer/account call to AppStore to save Chequebook and all Marketing Prefs missing x-journey-id - HTTP 400
        Given I set "PUT" method for "IPC_AccountData"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | global |
        And I set the headers for the request
            | Authorization |  |
        And I set the "IPC_PutAccountData" request body
        And I modify the following param values in the current request body
            | applicantRevision   | global | updateMarketingPreferencesRequest.applicantRevision |
            | applicantId         | global | updateMarketingPreferencesRequest.applicantId       |
            | applicationRevision | global | updateChequebookRequest.applicationRevision         |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the complete response body should be "MissingxjourneyId"

    @TestCaseKey=CAO-T997 @PutAccountData @error @400
    Scenario: IPC /customer/account call to AppStore to save Chequebook and all Marketing Prefs missing applicantId - HTTP 400
        Given I set "PUT" method for "IPC_AccountData"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "IPC_PutAccountData" request body
        And I modify the following param values in the current request body
            | applicantRevision   | global | updateMarketingPreferencesRequest.applicantRevision |
            | applicantId         | global | updateMarketingPreferencesRequest.applicantId       |
            | applicationRevision | global | updateChequebookRequest.applicationRevision         |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the complete response body should be "MissingApplicantId"

    @TestCaseKey=CAO-T998 @PutAccountData @error @400 @defect-12945
    Scenario: IPC /customer/account call to AppStore to save Chequebook and all Marketing Prefs with applicant preferences object removed - HTTP 400
        Given I set "PUT" method for "IPC_AccountData"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | global |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "IPC_PutAccountData" request body
        And I modify the following param values in the current request body
            | applicantRevision    | global | updateMarketingPreferencesRequest.applicantRevision |
            | applicantId          | global | updateMarketingPreferencesRequest.applicantId       |
            | applicationRevision  | global | updateChequebookRequest.applicationRevision         |
            | isChequeBookRequired | remove | updateChequebookRequest.applicantPreferences        |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the complete response body should be "InvalidRequest"

    @TestCaseKey=CAO-T999 @PutAccountData @error @401
    Scenario: IPC /customer/account call to AppStore to save Chequebook and all Marketing Prefs with no authorization - HTTP 401
        Given I set "PUT" method for "IPC_AccountData"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | global |
        And I set the headers for the request
            | x-journey-Id |  |
        And I set the "IPC_PutAccountData" request body
        And I modify the following param values in the current request body
            | applicantRevision   | global | updateMarketingPreferencesRequest.applicantRevision |
            | applicantId         | global | updateMarketingPreferencesRequest.applicantId       |
            | applicationRevision | global | updateChequebookRequest.applicationRevision         |
        When I send the request
        Then I verify the response status code as "401"
        And I verify the complete response body should be "Unauthorized"

    @TestCaseKey=CAO-T1000 @PutAccountData @error @500
    Scenario: IPC /customer/account call to AppStore to save Chequebook and all Marketing Prefs with empty body - HTTP 500
        Given I set "PUT" method for "IPC_AccountData"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | global |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "500"
        And I verify the complete response body should be "ApplicationUpdateCustomerChequebookDetailsError"

    @TestCaseKey=CAO-T1001 @PutAccountData @error @400
    Scenario: IPC /customer/account call to AppStore to save Chequebook and all Marketing Prefs with invalid applicant revision - HTTP 400
        Given I set "PUT" method for "IPC_AccountData"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | global |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "IPC_PutAccountData" request body
        And I modify the following param values in the current request body
            | applicantRevision   | hfysdguysdgf | updateMarketingPreferencesRequest.applicantRevision |
            | applicantId         | global       | updateMarketingPreferencesRequest.applicantId       |
            | applicationRevision | global       | updateChequebookRequest.applicationRevision         |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the complete response body should be "InvalidApplicantRevision"

    @TestCaseKey=CAO-T1002 @PutAccountData @error @400
    Scenario: IPC /customer/account call to AppStore to save Chequebook and all Marketing Prefs with invalid application revision - HTTP 400
        Given I set "PUT" method for "IPC_AccountData"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | global |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "IPC_PutAccountData" request body
        And I modify the following param values in the current request body
            | applicantRevision   | global         | updateMarketingPreferencesRequest.applicantRevision |
            | applicantId         | global         | updateMarketingPreferencesRequest.applicantId       |
            | applicationRevision | hdfiguhdfuhgud | updateChequebookRequest.applicationRevision         |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the complete response body should be "InvalidApplicationRevision"
