@api @regression @ipc
Feature: Scenarios for IPC Get Application status for the Switch Status end point

    # *************************************************
    #              HAPPY PATH SCENARIOS
    # *************************************************

    # IPC Service - /ipcservice/api/v1/applications/{appId}/status

    @happyPath  @TestCaseKey=CAO-T1227
    Scenario: IPC service switch status to check status code is approved: HTTP 200
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
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I poll the "eligiblity status" result
        And I verify the response status code as "200"
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
        Then I verify the response status code as "200"
        And I verify the complete response body should be "UpdateFATCADetails"
        And I set "PUT" method for "IPC_PerformSwitch"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "submitswitch" request body
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_applicantRevision   |
            | applicationRevision | global | Request_applicationRevision |
            | applicantId         | global | Request_applicantId         |
            | appId               | global | Request_appId               |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "SubmitSwitch"
        And I poll the "submit status" result
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_existingTaxDeclarationStatus | B         |
            | Response_getApplicationStatus_statusCode                   | Approved  |
            | Response_getApplicationStatus_agreedOverdraftLimit         | 100.00    |
            | Response_getApplicationStatus_isEligibleForAccount         | true      |
            | Response_getApplicationStatus_cardType                     | X2X DEBIT |
            | Response_getApplicationStatus_sortCode                     | 123456    |
            | Response_getApplicationStatus_accountNumber                | 12345678  |
            | Response_getApplicationStatus_serviceStatusCode            | 0         |
            | Response_getApplicationStatus_statusRetry                  | false     |
            | Response_getApplicationStatus_statusType                   | Success   |
            | Response_getApplicationStatus_statusMessage                | Success   |
            | Response_getApplicationStatus_errors                       |           |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                   | true            |
            | RAS_application_statusCode                             | Approved        |
            | RAS_application_statusReason                           | Account changed |
            | RAS_application_errors                                 |                 |
            | RAS_application_existingAccount_SortCode               | 123456          |
            | RAS_application_existingAccount_Number                 | 12345678        |
            | RAS_application_applicant_preferences_cardType         | X2X DEBIT       |
            | RAS_application_applicant_ExistingTaxDeclarationStatus | B               |
            | RAS_application_channelInfo_originatingChannel         | INTERNET        |
            | RAS_application_offeredProducts_promotions_id          | SFD0005         |
            | RAS_application_applicant_cisNo                        | 1211111111      |
            | RAS_application_offeredProducts_productId              | 7006            |

    @happyPath  @TestCaseKey=CAO-T1152
    Scenario: IPC service to perform switch when existingTaxDeclarationStatus is B or D and isLiableToPayTaxInAnotherCountry is false:HTTP 200
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
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I poll the "eligiblity status" result
        And I verify the response status code as "200"
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
        Then I verify the response status code as "200"
        And I verify the complete response body should be "UpdateFATCADetails"
        And I set "PUT" method for "IPC_PerformSwitch"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "submitswitch" request body
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_applicantRevision   |
            | applicationRevision | global | Request_applicationRevision |
            | applicantId         | global | Request_applicantId         |
            | appId               | global | Request_appId               |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "SubmitSwitch"
        And I poll the "submit status" result
        And I verify the response status code as "200"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                   | true            |
            | RAS_application_statusCode                             | Approved        |
            | RAS_application_statusReason                           | Account changed |
            | RAS_application_errors                                 |                 |
            | RAS_application_existingAccount_SortCode               | 123456          |
            | RAS_application_existingAccount_Number                 | 12345678        |
            | RAS_application_applicant_preferences_cardType         | X2X DEBIT       |
            | RAS_application_applicant_ExistingTaxDeclarationStatus | B               |
            | RAS_application_channelInfo_originatingChannel         | INTERNET        |
            | RAS_application_offeredProducts_promotions_id          | SFD0005         |
            | RAS_application_applicant_cisNo                        | 1211111111      |
            | RAS_application_offeredProducts_productId              | 7006            |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_nationalityAndTax_isDualNational                        | false |

    @happyPath  @TestCaseKey=CAO-T1153
    Scenario: IPC service to perform switch when existingTaxDeclarationStatus is B or D and isLiableToPayTaxInAnotherCountry is true:HTTP 200
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
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I poll the "eligiblity status" result
        And I verify the response status code as "200"
        And I set the "Updatefatcadetails" request body
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
        And I verify the complete response body should be "UpdateFATCADetails"
        And I set "PUT" method for "IPC_PerformSwitch"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "submitswitch" request body
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_applicantRevision   |
            | applicationRevision | global | Request_applicationRevision |
            | applicantId         | global | Request_applicantId         |
            | appId               | global | Request_appId               |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "SubmitSwitch"
        And I poll the "submit status" result
        And I verify the response status code as "200"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                   | true            |
            | RAS_application_statusCode                             | Approved        |
            | RAS_application_statusReason                           | Account changed |
            | RAS_application_errors                                 |                 |
            | RAS_application_existingAccount_SortCode               | 123456          |
            | RAS_application_existingAccount_Number                 | 12345678        |
            | RAS_application_applicant_preferences_cardType         | X2X DEBIT       |
            | RAS_application_applicant_ExistingTaxDeclarationStatus | B               |
            | RAS_application_channelInfo_originatingChannel         | INTERNET        |
            | RAS_application_offeredProducts_promotions_id          | SFD0005         |
            | RAS_application_applicant_cisNo                        | 1211111111      |
            | RAS_application_offeredProducts_productId              | 7006            |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_nationalityAndTax_isLiableToPayTaxInAnotherCountry | true       |
            | RAS_nationalityAndTax_isNonUkResidentForTaxPurposes    | true       |
            | RAS_nationalityAndTax_isUkResident                     | true       |
            | RAS_nationalityAndTax_isUsCitizen                      | false      |
            | RAS_nationalityAndTax_tinNumber1                       | A312DJEJFW |
            | RAS_nationalityAndTax_country1                         | IN         |
            | RAS_nationalityAndTax_isDualNational                   | false      |

    @happyPath  @TestCaseKey=CAO-T1154
    Scenario: IPC service to perform switch when save Chequebook and all Marketing Prefs to true:HTTP 200
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
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I poll the "eligiblity status" result
        And I verify the response status code as "200"
        And I set the "Updatefatcadetails" request body
        And I set "PUT" method for "IPC_FATCADetails"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | global |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision | global | Request_updateFatcaDetails_applicantRevision |
            | applicantId       | global | Request_updateFatcaDetails_applicantId       |
        And I send the request
        And I verify the response status code as "200"
        And I verify the complete response body should be "UpdateFATCADetails"
        And I set "PUT" method for "IPC_AccountData"
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
        And I send the request
        And I verify the response status code as "200"
        And I verify the complete response body should be "PutAccountData"
        And I set "PUT" method for "IPC_PerformSwitch"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "submitswitch" request body
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_applicantRevision   |
            | applicationRevision | global | Request_applicationRevision |
            | applicantId         | global | Request_applicantId         |
            | appId               | global | Request_appId               |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "SubmitSwitch"
        And I poll the "submit status" result
        And I verify the response status code as "200"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                   | true            |
            | RAS_application_statusCode                             | Approved        |
            | RAS_application_statusReason                           | Account changed |
            | RAS_application_errors                                 |                 |
            | RAS_application_existingAccount_SortCode               | 123456          |
            | RAS_application_existingAccount_Number                 | 12345678        |
            | RAS_application_applicant_preferences_cardType         | X2X DEBIT       |
            | RAS_application_applicant_ExistingTaxDeclarationStatus | Y               |
            | RAS_application_channelInfo_originatingChannel         | INTERNET        |
            | RAS_application_offeredProducts_promotions_id          | SFD0005         |
            | RAS_application_applicant_cisNo                        | 1234567890      |
            | RAS_application_offeredProducts_productId              | 7006            |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_marketingPref_isEmailPreferred                | true  |
            | RAS_applicant_marketingPref_isPhonePreferred                | true  |
            | RAS_applicant_marketingPref_isMailPreferred                 | true  |
            | RAS_applicant_marketingPref_UpdateMarketingPreferencesOnCIS | true  |
            | RAS_nationalityAndTax_isDualNational                        | false |

    @happyPath  @TestCaseKey=CAO-T1155
    Scenario: IPC service to perform switch when save Chequebook and all Marketing Prefs to false:HTTP 200
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
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I poll the "eligiblity status" result
        And I verify the response status code as "200"
        And I set the "Updatefatcadetails" request body
        And I set "PUT" method for "IPC_FATCADetails"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision | global | Request_updateFatcaDetails_applicantRevision |
            | applicantId       | global | Request_updateFatcaDetails_applicantId       |
        And I send the request
        And I verify the response status code as "200"
        And I verify the complete response body should be "UpdateFATCADetails"
        And I set "PUT" method for "IPC_AccountData"
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
        And I send the request
        And I verify the response status code as "200"
        And I verify the complete response body should be "PutAccountData"
        And I set "PUT" method for "IPC_PerformSwitch"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "submitswitch" request body
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_applicantRevision   |
            | applicationRevision | global | Request_applicationRevision |
            | applicantId         | global | Request_applicantId         |
            | appId               | global | Request_appId               |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "SubmitSwitch"
        And I poll the "submit status" result
        And I verify the response status code as "200"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                   | true            |
            | RAS_application_statusCode                             | Approved        |
            | RAS_application_statusReason                           | Account changed |
            | RAS_application_errors                                 |                 |
            | RAS_application_existingAccount_SortCode               | 123456          |
            | RAS_application_existingAccount_Number                 | 12345678        |
            | RAS_application_applicant_preferences_cardType         | X2X DEBIT       |
            | RAS_application_applicant_ExistingTaxDeclarationStatus | Y               |
            | RAS_application_channelInfo_originatingChannel         | INTERNET        |
            | RAS_application_offeredProducts_promotions_id          | SFD0005         |
            | RAS_application_applicant_cisNo                        | 1234567890      |
            | RAS_application_offeredProducts_productId              | 7006            |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_marketingPref_isEmailPreferred                | false |
            | RAS_applicant_marketingPref_isPhonePreferred                | false |
            | RAS_applicant_marketingPref_isMailPreferred                 | false |
            | RAS_applicant_marketingPref_UpdateMarketingPreferencesOnCIS | true  |
            | RAS_nationalityAndTax_isDualNational                        | false |

    @happyPath  @TestCaseKey=CAO-T1156
    Scenario: IPC service to perform switch when only Chequebook required but no Marketing Prefs in request:HTTP 200
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
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I poll the "eligiblity status" result
        And I verify the response status code as "200"
        And I set the "Updatefatcadetails" request body
        And I set "PUT" method for "IPC_FATCADetails"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision | global | Request_updateFatcaDetails_applicantRevision |
            | applicantId       | global | Request_updateFatcaDetails_applicantId       |
        And I send the request
        And I verify the response status code as "200"
        And I verify the complete response body should be "UpdateFATCADetails"
        And I set "PUT" method for "IPC_AccountData"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | applicantId | global |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "IPC_PutAccountData" request body
        And I modify the following param values in the current request body
            | updateMarketingPreferencesRequest | remove    | updateMarketingPreferencesRequest                                 |
            | applicationRevision               | global    | updateChequebookRequest.applicationRevision                       |
            | isChequeBookRequired              | true      | updateChequebookRequest.applicantPreferences.isChequeBookRequired |
            | cardType                          | X2X DEBIT | updateChequebookRequest.applicantPreferences.cardType             |
        And I send the request
        And I verify the response status code as "200"
        And I verify the complete response body should be "PutAccountDataNoMarketingPrefs"
        And I set "PUT" method for "IPC_PerformSwitch"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "submitswitch" request body
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_applicantRevision   |
            | applicationRevision | global | Request_applicationRevision |
            | applicantId         | global | Request_applicantId         |
            | appId               | global | Request_appId               |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "SubmitSwitch"
        And I poll the "submit status" result
        And I verify the response status code as "200"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                       | true            |
            | RAS_application_statusCode                                 | Approved        |
            | RAS_application_statusReason                               | Account changed |
            | RAS_application_errors                                     |                 |
            | RAS_application_existingAccount_SortCode                   | 123456          |
            | RAS_application_existingAccount_Number                     | 12345678        |
            | RAS_application_applicant_preferences_cardType             | X2X DEBIT       |
            | RAS_application_applicant_preferences_isChequebookRequired | true            |
            | RAS_application_applicant_ExistingTaxDeclarationStatus     | B               |
            | RAS_application_channelInfo_originatingChannel             | INTERNET        |
            | RAS_application_offeredProducts_promotions_id              | SFD0005         |
            | RAS_application_applicant_cisNo                            | 1211111111      |
            | RAS_application_offeredProducts_productId                  | 7006            |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_nationalityAndTax_isDualNational                   | false       |

    @happyPath  @TestCaseKey=CAO-T1157
    Scenario: IPC service to perform switch when Checkbook required false and all Marketing Prefs with varied values:HTTP 200
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
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I poll the "eligiblity status" result
        And I verify the response status code as "200"
        And I set the "Updatefatcadetails" request body
        And I set "PUT" method for "IPC_FATCADetails"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision | global | Request_updateFatcaDetails_applicantRevision |
            | applicantId       | global | Request_updateFatcaDetails_applicantId       |
        And I send the request
        And I verify the response status code as "200"
        And I verify the complete response body should be "UpdateFATCADetails"
        And I set "PUT" method for "IPC_AccountData"
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
            | isEmailPreferred     | true   | updateMarketingPreferencesRequest.isEmailPreferred                |
            | isMailPreferred      | remove | updateMarketingPreferencesRequest.isMailPreferred                 |
            | isPhonePreferred     | false  | updateMarketingPreferencesRequest.isPhonePreferred                |
            | isChequeBookRequired | false  | updateChequebookRequest.applicantPreferences.isChequeBookRequired |
        And I send the request
        And I verify the response status code as "200"
        And I verify the complete response body should be "PutAccountData"
        And I set "PUT" method for "IPC_PerformSwitch"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "submitswitch" request body
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_applicantRevision   |
            | applicationRevision | global | Request_applicationRevision |
            | applicantId         | global | Request_applicantId         |
            | appId               | global | Request_appId               |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "SubmitSwitch"
        And I poll the "submit status" result
        And I verify the response status code as "200"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                   | true            |
            | RAS_application_statusCode                             | Approved        |
            | RAS_application_statusReason                           | Account changed |
            | RAS_application_errors                                 |                 |
            | RAS_application_existingAccount_SortCode               | 123456          |
            | RAS_application_existingAccount_Number                 | 12345678        |
            | RAS_application_applicant_preferences_cardType         | X2X DEBIT       |
            | RAS_application_applicant_ExistingTaxDeclarationStatus | Y               |
            | RAS_application_channelInfo_originatingChannel         | INTERNET        |
            | RAS_application_offeredProducts_promotions_id          | SFD0005         |
            | RAS_application_applicant_cisNo                        | 1234567890      |
            | RAS_application_offeredProducts_productId              | 7006            |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_marketingPref_isEmailPreferred                | true  |
            | RAS_applicant_marketingPref_isPhonePreferred                | false |
            | RAS_applicant_marketingPref_isMailPreferred                 | null  |
            | RAS_applicant_marketingPref_UpdateMarketingPreferencesOnCIS | true  |
            | RAS_nationalityAndTax_isDualNational                        | false |

    @happyPath  @TestCaseKey=CAO-T1158
    Scenario: IPC service to perform switch when Update Terms and Conditions end point for all 5 signed documents:HTTP 200
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
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I poll the "eligiblity status" result
        And I verify the response status code as "200"
        And I set the "Updatefatcadetails" request body
        And I set "PUT" method for "IPC_FATCADetails"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision | global | Request_updateFatcaDetails_applicantRevision |
            | applicantId       | global | Request_updateFatcaDetails_applicantId       |
        And I send the request
        And I verify the response status code as "200"
        And I verify the complete response body should be "UpdateFATCADetails"
        And I set "PUT" method for "IPC_AccountData"
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
            | isEmailPreferred     | true   | updateMarketingPreferencesRequest.isEmailPreferred                |
            | isMailPreferred      | remove | updateMarketingPreferencesRequest.isMailPreferred                 |
            | isPhonePreferred     | false  | updateMarketingPreferencesRequest.isPhonePreferred                |
            | isChequeBookRequired | false  | updateChequebookRequest.applicantPreferences.isChequeBookRequired |
        And I send the request
        And I verify the response status code as "200"
        And I verify the complete response body should be "PutAccountData"
        And I set "PUT" method for "IPC_TermsAndConditions"
        And I set the "IPC_TermsAndConditionsWithOD" request body
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | appId               | global | Request_appId               |
            | applicantId         | global | Request_applicantId         |
            | applicationRevision | global | Request_applicationRevision |
        And I send the request
        And I verify the response status code as "200"
        And I verify the complete response body should be "PutTermsAndConditions"
        And I set "PUT" method for "IPC_PerformSwitch"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "submitswitch" request body
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_applicantRevision   |
            | applicationRevision | global | Request_applicationRevision |
            | applicantId         | global | Request_applicantId         |
            | appId               | global | Request_appId               |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "SubmitSwitch"
        And I poll the "submit status" result
        And I verify the response status code as "200"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                   | true            |
            | RAS_application_statusCode                             | Approved        |
            | RAS_application_statusReason                           | Account changed |
            | RAS_application_errors                                 |                 |
            | RAS_application_existingAccount_SortCode               | 123456          |
            | RAS_application_existingAccount_Number                 | 12345678        |
            | RAS_application_applicant_preferences_cardType         | X2X DEBIT       |
            | RAS_application_applicant_ExistingTaxDeclarationStatus | Y               |
            | RAS_application_channelInfo_originatingChannel         | INTERNET        |
            | RAS_application_offeredProducts_promotions_id          | SFD0005         |
            | RAS_application_applicant_cisNo                        | 1234567890      |
            | RAS_application_offeredProducts_productId              | 7006            |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_marketingPref_isEmailPreferred                | true  |
            | RAS_applicant_marketingPref_isPhonePreferred                | false |
            | RAS_applicant_marketingPref_isMailPreferred                 | null  |
            | RAS_applicant_marketingPref_UpdateMarketingPreferencesOnCIS | true  |
            | RAS_nationalityAndTax_isDualNational                        | false |

    @happyPath  @TestCaseKey=CAO-T1159
    Scenario: IPC service to perform switch when Update Terms and Conditions service for 3 signed documents:HTTP 200
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
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I poll the "eligiblity status" result
        And I verify the response status code as "200"
        And I set the "Updatefatcadetails" request body
        And I set "PUT" method for "IPC_FATCADetails"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | applicantRevision | global | Request_updateFatcaDetails_applicantRevision |
            | applicantId       | global | Request_updateFatcaDetails_applicantId       |
        And I send the request
        And I verify the response status code as "200"
        And I verify the complete response body should be "UpdateFATCADetails"
        And I set "PUT" method for "IPC_AccountData"
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
            | isEmailPreferred     | true   | updateMarketingPreferencesRequest.isEmailPreferred                |
            | isMailPreferred      | remove | updateMarketingPreferencesRequest.isMailPreferred                 |
            | isPhonePreferred     | false  | updateMarketingPreferencesRequest.isPhonePreferred                |
            | isChequeBookRequired | false  | updateChequebookRequest.applicantPreferences.isChequeBookRequired |
        And I send the request
        And I verify the response status code as "200"
        And I verify the complete response body should be "PutAccountData"
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
        And I send the request
        And I verify the response status code as "200"
        And I verify the complete response body should be "PutTermsAndConditions"
        And I set "PUT" method for "IPC_PerformSwitch"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "submitswitch" request body
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_applicantRevision   |
            | applicationRevision | global | Request_applicationRevision |
            | applicantId         | global | Request_applicantId         |
            | appId               | global | Request_appId               |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "SubmitSwitch"
        And I poll the "submit status" result
        And I verify the response status code as "200"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount                   | true            |
            | RAS_application_statusCode                             | Approved        |
            | RAS_application_statusReason                           | Account changed |
            | RAS_application_errors                                 |                 |
            | RAS_application_existingAccount_SortCode               | 123456          |
            | RAS_application_existingAccount_Number                 | 12345678        |
            | RAS_application_applicant_preferences_cardType         | X2X DEBIT       |
            | RAS_application_applicant_ExistingTaxDeclarationStatus | Y               |
            | RAS_application_channelInfo_originatingChannel         | INTERNET        |
            | RAS_application_offeredProducts_promotions_id          | SFD0005         |
            | RAS_application_applicant_cisNo                        | 1234567890      |
            | RAS_application_offeredProducts_productId              | 7006            |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_marketingPref_isEmailPreferred                | true  |
            | RAS_applicant_marketingPref_isPhonePreferred                | false |
            | RAS_applicant_marketingPref_isMailPreferred                 | null  |
            | RAS_applicant_marketingPref_UpdateMarketingPreferencesOnCIS | true  |
            | RAS_nationalityAndTax_isDualNational                        | false |

    @happyPath  @TestCaseKey=CAO-T1236
    Scenario: IPC service Get Application status for switch service when NEM service, PUT IP and Comms service are all success: HTTP 200
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
        And I verify the response status code as "202"
        And I poll the "eligiblity status" result
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_isEligibleForAccount         | true       |
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
        Given I set "PUT" method for "IPC_PerformSwitch"
        And I set the "IPC_PerformSwitch" request body
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | appId               | global | Request_appId               |
            | applicantId         | global | Request_applicantId         |
            | applicationRevision | global | Request_applicationRevision |
            | applicantRevision   | global | Request_applicantRevision   |
        When I send the request
        Then I verify the response status code as "202"
       And I poll the "submit status" result
       And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_statusCode           | Approved |
            | Response_getApplicationStatus_isEligibleForAccount | true     |
            | Response_getApplicationStatus_errors               | null     |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_statusCode   | Approved        |
            | RAS_application_statusReason | Account changed |
            | RAS_application_errors       | null            |

    @happyPath  @TestCaseKey=CAO-T1237
    Scenario: IPC service Get Application status for switch service when NEM switch and PUT IP services are success & comms service fails: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1391111111"
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
        And I verify the response status code as "202"
        And I poll the "eligiblity status" result
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_isEligibleForAccount         | true       |
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
        Given I set "PUT" method for "IPC_PerformSwitch"
        And I set the "IPC_PerformSwitch" request body
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | appId               | global | Request_appId               |
            | applicantId         | global | Request_applicantId         |
            | applicationRevision | global | Request_applicationRevision |
            | applicantRevision   | global | Request_applicantRevision   |
        When I send the request
        Then I verify the response status code as "202"
        And I poll the "submit status" result
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_statusCode | Approved                                                    |
            | Response_getApplicationStatus_errorCode  | 500                                                         |
            | Response_getApplicationStatus_errorMessage   | Given PhoneNumber has not been whitelisted : 00447467735718 |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_statusCode   | Approved                                                    |
            | RAS_application_statusReason | Account changed                                             |
            | RAS_application_errorCode    | 500                                                         |
            | RAS_application_errorMessage | Given PhoneNumber has not been whitelisted : 00447467735718 |

    @happyPath  @TestCaseKey=CAO-T1238
    Scenario: IPC service Get Application status for switch service when NEM switch and comms services are success & PUT IP service fails with 400: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111158"
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
        And I verify the response status code as "202"
        And I poll the "eligiblity status" result
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_isEligibleForAccount         | true       |
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
        Given I set "PUT" method for "IPC_PerformSwitch"
        And I set the "IPC_PerformSwitch" request body
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | appId               | global | Request_appId               |
            | applicantId         | global | Request_applicantId         |
            | applicationRevision | global | Request_applicationRevision |
            | applicantRevision   | global | Request_applicantRevision   |
        When I send the request
        Then I verify the response status code as "202"
        And I poll the "submit status" result
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_statusCode | Approved                             |
            | Response_getApplicationStatus_errorCode  | 400                                  |
            | Response_getApplicationStatus_errorMessage          | The Schema Rules Validation Failed.. |
            | Response_getApplicationStatus_errorCode2 | 400                                  |
            | Response_getApplicationStatus_errorMessage2         | A Required Field is Missing.         |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_statusCode    | Approved                             |
            | RAS_application_statusReason  | Account changed                      |
            | RAS_application_errorCode     | 400                                  |
            | RAS_application_errorMessage  | The Schema Rules Validation Failed.. |
            | RAS_application_errorCode2    | 400                                  |
            | RAS_application_errorMessage2 | A Required Field is Missing.         |

    @happyPath  @TestCaseKey=CAO-T1239
    Scenario: IPC service Get Application status for switch service when NEM switch and comms services are success & PUT IP service fails with 401: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111159"
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
        And I verify the response status code as "202"
        And I poll the "eligiblity status" result
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_isEligibleForAccount         | true       |
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
        Given I set "PUT" method for "IPC_PerformSwitch"
        And I set the "IPC_PerformSwitch" request body
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | appId               | global | Request_appId               |
            | applicantId         | global | Request_applicantId         |
            | applicationRevision | global | Request_applicationRevision |
            | applicantRevision   | global | Request_applicantRevision   |
        When I send the request
        Then I verify the response status code as "202"
        And I poll the "submit status" result
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_statusCode | Approved              |
            | Response_getApplicationStatus_errorCode  | 401                   |
            | Response_getApplicationStatus_errorMessage            | JWT Not Authenticated |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_statusCode   | Approved              |
            | RAS_application_statusReason | Account changed       |
            | RAS_application_errorCode    | 401                   |
            | RAS_application_errorMessage | JWT Not Authenticated |

    @happyPath  @TestCaseKey=CAO-T1240
    Scenario: IPC service Get Application status for switch service when NEM switch and comms services are success & PUT IP service fails with 500: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111160"
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
        And I verify the response status code as "202"
        And I poll the "eligiblity status" result
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_isEligibleForAccount         | true       |
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
        Given I set "PUT" method for "IPC_PerformSwitch"
        And I set the "IPC_PerformSwitch" request body
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | appId               | global | Request_appId               |
            | applicantId         | global | Request_applicantId         |
            | applicationRevision | global | Request_applicationRevision |
            | applicantRevision   | global | Request_applicantRevision   |
        When I send the request
        Then I verify the response status code as "202"
        And I poll the "submit status" result
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_statusCode    | Approved |
            | Response_getApplicationStatus_errorCode     | 500      |
            | Response_getApplicationStatus_errorMessage              | ABORT    |
            | Response_getApplicationStatus_errorCode2    | 500      |
            | Response_getApplicationStatus_errorMessage2             | REJECTED |
            | Response_getApplicationStatus_errorCode3    | 500      |
            | Response_getApplicationStatus_errorMessage3 | INTERNAL |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_statusCode   | Approved        |
            | RAS_application_statusReason | Account changed |
            | RAS_application_errorCode    | 500             |
            | RAS_application_errorMessage | ABORT           |

    @happyPath  @TestCaseKey=CAO-T1241
    Scenario: IPC service Get Application status for switch service when NEM switch and comms services are success & PUT IP service fails with 502: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111161"
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
        And I verify the response status code as "202"
        And I poll the "eligiblity status" result
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_isEligibleForAccount         | true       |
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
        Given I set "PUT" method for "IPC_PerformSwitch"
        And I set the "IPC_PerformSwitch" request body
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | appId               | global | Request_appId               |
            | applicantId         | global | Request_applicantId         |
            | applicationRevision | global | Request_applicationRevision |
            | applicantRevision   | global | Request_applicantRevision   |
        When I send the request
        Then I verify the response status code as "202"
        And I poll the "submit status" result
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_statusCode | Approved |
            | Response_getApplicationStatus_errorCode  | 502      |
            | Response_getApplicationStatus_errorMessage           | REJECTED |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_statusCode   | Approved        |
            | RAS_application_statusReason | Account changed |
            | RAS_application_errorCode    | 502             |
            | RAS_application_errorMessage | REJECTED        |

    @happyPath  @TestCaseKey=CAO-T1242
    Scenario: IPC service Get Application status for switch service when NEM switch and comms services are success & PUT IP service fails with 503: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111162"
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
        And I verify the response status code as "202"
        And I poll the "eligiblity status" result
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_isEligibleForAccount         | true       |
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
        Given I set "PUT" method for "IPC_PerformSwitch"
        And I set the "IPC_PerformSwitch" request body
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | appId               | global | Request_appId               |
            | applicantId         | global | Request_applicantId         |
            | applicationRevision | global | Request_applicationRevision |
            | applicantRevision   | global | Request_applicantRevision   |
        When I send the request
        Then I verify the response status code as "202"
        And I poll the "submit status" result
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_statusCode | Approved    |
            | Response_getApplicationStatus_errorCode  | 503         |
            | Response_getApplicationStatus_errorMessage          | UNAVAILABLE |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_statusCode   | Approved        |
            | RAS_application_statusReason | Account changed |
            | RAS_application_errorCode    | 503             |
            | RAS_application_errorMessage | UNAVAILABLE     |

    @happyPath  @TestCaseKey=CAO-T1243
    Scenario: IPC service Get Application status for switch service when NEM switch and comms services are success & PUT IP service fails with 504: HTTP 200
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111163"
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
        And I verify the response status code as "202"
        And I poll the "eligiblity status" result
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_isEligibleForAccount         | true       |
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
        Given I set "PUT" method for "IPC_PerformSwitch"
        And I set the "IPC_PerformSwitch" request body
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | appId               | global | Request_appId               |
            | applicantId         | global | Request_applicantId         |
            | applicationRevision | global | Request_applicationRevision |
            | applicantRevision   | global | Request_applicantRevision   |
        When I send the request
        Then I verify the response status code as "202"
        And I poll the "submit status" result
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_statusCode | Approved    |
            | Response_getApplicationStatus_errorCode  | 504         |
            | Response_getApplicationStatus_errorMessage          | UNAVAILABLE |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_statusCode   | Approved        |
            | RAS_application_statusReason | Account changed |
            | RAS_application_errorCode    | 504             |
            | RAS_application_errorMessage | UNAVAILABLE     |

    # *************************************************************
    #           #######   ERROR SCENARIOS   #########
    # *************************************************************

    @switchFailure  @TestCaseKey=CAO-T1244
    Scenario: IPC service Get Application status for switch service when NEM switch service fails & PUT IP and comms services are success: HTTP 200
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
            | accountNumber       | 10000011 | Request_eligibility_accountNo           |
        And I send the request
        And I verify the response status code as "202"
        And I poll the "eligiblity status" result
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_isEligibleForAccount         | true       |
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
        And I set "PUT" method for "IPC_TermsAndConditions"
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
        Given I set "PUT" method for "IPC_PerformSwitch"
        And I set the "IPC_PerformSwitch" request body
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | appId               | global | Request_appId               |
            | applicantId         | global | Request_applicantId         |
            | applicationRevision | global | Request_applicationRevision |
            | applicantRevision   | global | Request_applicantRevision   |
        When I send the request
        Then I verify the response status code as "202"
        And I set "GET" method for "IPC_ApplicationStatus"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_statusCode | Terminated                                                                 |
            | Response_getApplicationStatus_errorCode  | 400                                                                        |
            | Response_getApplicationStatus_errorMessage           | NEM Switch Service Error - Bad Request - General Schema Validation Failure |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_statusCode   | Terminated                                                                 |
            | RAS_application_statusReason | Failure on submit                                                          |
            | RAS_application_errorCode    | 400                                                                        |
            | RAS_application_errorMessage | NEM Switch Service Error - Bad Request - General Schema Validation Failure |

    @switchFailure @TestCaseKey=CAO-T1161
    Scenario: IPC perform switch service when NEM General Schema Validation Failure:HTTP 200
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
            | sortCode            | 123456   | Request_eligibility_sortCode            |
            | accountNumber       | 10000011 | Request_eligibility_accountNo           |
            | applicantRevision   | global   | Request_eligibility_applicantRevision   |
            | applicationRevision | global   | Request_eligibility_applicationRevision |
            | applicantId         | global   | Request_eligibility_applicantId         |
        And I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I poll the "eligiblity status" result
        And I verify the response status code as "200"
        And I set "PUT" method for "IPC_PerformSwitch"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "submitswitch" request body
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_applicantRevision   |
            | applicationRevision | global | Request_applicationRevision |
            | applicantId         | global | Request_applicantId         |
            | appId               | global | Request_appId               |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "SubmitSwitch"
        And I poll the "submit status" result
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_existingTaxDeclarationStatus | Y                                                                          |
            | Response_getApplicationStatus_statusCode                   | Terminated                                                                 |
            | Response_getApplicationStatus_isEligibleForAccount         | true                                                                       |
            | Response_getApplicationStatus_errorCode                    | 400                                                                        |
            | Response_getApplicationStatus_errorMessage                 | NEM Switch Service Error - Bad Request - General Schema Validation Failure |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | true                                                                       |
            | RAS_application_statusCode               | Terminated                                                                 |
            | RAS_application_eligibility_errorCode    | 400                                                                        |
            | RAS_application_eligibility_errorMessage | NEM Switch Service Error - Bad Request - General Schema Validation Failure |

    @switchFailure @TestCaseKey=CAO-T1162
    Scenario: IPC perform switch service when NEM JWT Not Authenticated:HTTP 200
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
            | sortCode            | 123456   | Request_eligibility_sortCode            |
            | accountNumber       | 10000012 | Request_eligibility_accountNo           |
            | applicantRevision   | global   | Request_eligibility_applicantRevision   |
            | applicationRevision | global   | Request_eligibility_applicationRevision |
            | applicantId         | global   | Request_eligibility_applicantId         |
        And I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I poll the "eligiblity status" result
        And I verify the response status code as "200"
        And I set "PUT" method for "IPC_PerformSwitch"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "submitswitch" request body
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_applicantRevision   |
            | applicationRevision | global | Request_applicationRevision |
            | applicantId         | global | Request_applicantId         |
            | appId               | global | Request_appId               |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "SubmitSwitch"
        And I poll the "submit status" result
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_existingTaxDeclarationStatus | Y                                                               |
            | Response_getApplicationStatus_statusCode                   | Terminated                                                      |
            | Response_getApplicationStatus_isEligibleForAccount         | true                                                            |
            | Response_getApplicationStatus_errorCode                    | 401                                                             |
            | Response_getApplicationStatus_errorMessage                 | NEM Switch Service Error - Unauthorized - JWT Not Authenticated |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | true                                                            |
            | RAS_application_statusCode               | Terminated                                                      |
            | RAS_application_eligibility_errorCode    | 401                                                             |
            | RAS_application_eligibility_errorMessage | NEM Switch Service Error - Unauthorized - JWT Not Authenticated |

    @switchFailure @TestCaseKey=CAO-T1163
    Scenario: IPC perform switch service when NEM Downstream Token Security Error:HTTP 200
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
            | sortCode            | 123456   | Request_eligibility_sortCode            |
            | accountNumber       | 10000013 | Request_eligibility_accountNo           |
            | applicantRevision   | global   | Request_eligibility_applicantRevision   |
            | applicationRevision | global   | Request_eligibility_applicationRevision |
            | applicantId         | global   | Request_eligibility_applicantId         |
        And I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I poll the "eligiblity status" result
        And I verify the response status code as "200"
        And I set "PUT" method for "IPC_PerformSwitch"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "submitswitch" request body
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_applicantRevision   |
            | applicationRevision | global | Request_applicationRevision |
            | applicantId         | global | Request_applicantId         |
            | appId               | global | Request_appId               |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "SubmitSwitch"
        And I poll the "submit status" result
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_existingTaxDeclarationStatus | Y                                                                                  |
            | Response_getApplicationStatus_statusCode                   | Terminated                                                                         |
            | Response_getApplicationStatus_isEligibleForAccount         | true                                                                               |
            | Response_getApplicationStatus_errorCode                    | 500                                                                                |
            | Response_getApplicationStatus_errorMessage                 | NEM Switch Service Error - Internal Server Error - Downstream Token Security Error |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | true                                                                               |
            | RAS_application_statusCode               | Terminated                                                                         |
            | RAS_application_eligibility_errorCode    | 500                                                                                |
            | RAS_application_eligibility_errorMessage | NEM Switch Service Error - Internal Server Error - Downstream Token Security Error |

    @switchFailure @TestCaseKey=CAO-T1164
    Scenario: IPC perform switch service when NEM service could not connect to the SoR:HTTP 200
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
            | sortCode            | 123456   | Request_eligibility_sortCode            |
            | accountNumber       | 10000014 | Request_eligibility_accountNo           |
            | applicantRevision   | global   | Request_eligibility_applicantRevision   |
            | applicationRevision | global   | Request_eligibility_applicationRevision |
            | applicantId         | global   | Request_eligibility_applicantId         |
        And I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I poll the "eligiblity status" result
        And I verify the response status code as "200"
        And I set "PUT" method for "IPC_PerformSwitch"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "submitswitch" request body
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_applicantRevision   |
            | applicationRevision | global | Request_applicationRevision |
            | applicantId         | global | Request_applicantId         |
            | appId               | global | Request_appId               |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "SubmitSwitch"
        And I poll the "submit status" result
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_existingTaxDeclarationStatus | Y                                                                                         |
            | Response_getApplicationStatus_statusCode                   | Terminated                                                                                |
            | Response_getApplicationStatus_isEligibleForAccount         | true                                                                                      |
            | Response_getApplicationStatus_errorCode                    | 503                                                                                       |
            | Response_getApplicationStatus_errorMessage                 | NEM Switch Service Error - Service Unavailable - The service could not connect to the SoR |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | true                                                                                      |
            | RAS_application_statusCode               | Terminated                                                                                |
            | RAS_application_eligibility_errorCode    | 503                                                                                       |
            | RAS_application_eligibility_errorMessage | NEM Switch Service Error - Service Unavailable - The service could not connect to the SoR |

    @switchFailure @TestCaseKey=CAO-T1165
    Scenario: IPC perform switch service when NEM underlying SoR timed out:HTTP 200
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
            | sortCode            | 123456   | Request_eligibility_sortCode            |
            | accountNumber       | 10000015 | Request_eligibility_accountNo           |
            | applicantRevision   | global   | Request_eligibility_applicantRevision   |
            | applicationRevision | global   | Request_eligibility_applicationRevision |
            | applicantId         | global   | Request_eligibility_applicantId         |
        And I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "Eligibility_response"
        And I poll the "eligiblity status" result
        And I verify the response status code as "200"
        And I set "PUT" method for "IPC_PerformSwitch"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I set the "submitswitch" request body
        And I modify the following param values in the current request body
            | applicantRevision   | global | Request_applicantRevision   |
            | applicationRevision | global | Request_applicationRevision |
            | applicantId         | global | Request_applicantId         |
            | appId               | global | Request_appId               |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "SubmitSwitch"
        And I poll the "submit status" result
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_getApplicationStatus_existingTaxDeclarationStatus | Y                                                                          |
            | Response_getApplicationStatus_statusCode                   | Terminated                                                                 |
            | Response_getApplicationStatus_isEligibleForAccount         | true                                                                       |
            | Response_getApplicationStatus_errorCode                    | 504                                                                        |
            | Response_getApplicationStatus_errorMessage                 | NEM Switch Service Error - Gateway Time Out - The underlying SoR timed out |
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_isEligibleForAccount     | true                                                                       |
            | RAS_application_statusCode               | Terminated                                                                 |
            | RAS_application_eligibility_errorCode    | 504                                                                        |
            | RAS_application_eligibility_errorMessage | NEM Switch Service Error - Gateway Time Out - The underlying SoR timed out |