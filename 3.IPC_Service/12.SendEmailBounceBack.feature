@api @regression @ipc
Feature: Scenarios for the IPC service to perform EmailBounceBack

    # *************************************************
    #              HAPPY PATH SCENARIOS
    # *************************************************

    # IPC Service - /ipcservice/api/v1/applications/{appId}/SendEmailBounceback

    @happyPath  @TestCaseKey=CAO-T1254
    Scenario: IPC service to perform successful sendEmailBounceBack call:HTTP 202
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1421111141"
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
        And I set the "sendemailbounceback" request body
        And I set "POST" method for "IPC_SendEmailBounceback"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | appId       | global | Request_appId       |
            | applicantId | global | Request_applicantId |
        When I send the request
        Then I verify the response status code as "202"
        And I verify the complete response body should be "SendEmailBounceBack"

    # *************************************************
    #             ERROR SCENARIOS
    # *************************************************

    @error @400 @TestCaseKey=CAO-T1255
    Scenario: IPC calls SendEmailBounceBack service when the app id is invalid:HTTP 400
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
        And I "update" the following global values
            | appId | hfysdgfsd |
        And I set the "sendemailbounceback" request body
        And I set "POST" method for "IPC_SendEmailBounceback"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | appId       | global | Request_appId       |
            | applicantId | global | Request_applicantId |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the complete response body should be "InvalidAppId"

    @error @400 @TestCaseKey=CAO-T1256
    Scenario: IPC calls SendEmailBounceBack service when the x-journey-id is invalid:HTTP 400
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
        And I set the "sendemailbounceback" request body
        And I set "POST" method for "IPC_SendEmailBounceback"
        And I set the config for the request to "default"
        And I "update" the following global values
            | x-journey-id | 111111 |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | appId       | global | Request_appId       |
            | applicantId | global | Request_applicantId |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the complete response body should be "InvalidxjourneyId"

    @error @400 @TestCaseKey=CAO-T1257
    Scenario: IPC calls SendEmailBounceBack service when the x-journey-id is missing:HTTP 400
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
        And I set the "sendemailbounceback" request body
        And I set "POST" method for "IPC_SendEmailBounceback"
        And I set the config for the request to "default"
        And I set the headers for the request
            | Authorization |  |
        And I modify the following param values in the current request body
            | appId       | global | Request_appId       |
            | applicantId | global | Request_applicantId |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the complete response body should be "MissingxjourneyId"

    @error @401 @TestCaseKey=CAO-T1258
    Scenario: IPC calls SendEmailBounceBack service when the Authorization token is invalid:HTTP 401
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
        And I set the "sendemailbounceback" request body
        And I set "POST" method for "IPC_SendEmailBounceback"
        And I set the config for the request to "default"
        And I "update" the following global values
            | jwt | hfysdgfsd |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | appId       | global | Request_appId       |
            | applicantId | global | Request_applicantId |
        When I send the request
        Then I verify the response status code as "401"
        And I verify the complete response body should be "Unauthorized"

    @error @401 @TestCaseKey=CAO-T1259
    Scenario: IPC calls SendEmailBounceBack service when the Authorization token is missing:HTTP 401
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
        And I set the config for the request to "default"
        And I set the "sendemailbounceback" request body
        And I set "POST" method for "IPC_SendEmailBounceback"
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id |  |
        And I modify the following param values in the current request body
            | appId       | global | Request_appId       |
            | applicantId | global | Request_applicantId |
        When I send the request
        Then I verify the response status code as "401"
        And I verify the complete response body should be "Unauthorized"