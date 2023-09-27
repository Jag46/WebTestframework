@api @regression @ipc
Feature: Scenarios for the IPC service Create application end point

    Background: Generate JWT for use in token handler calls
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1111111119"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number " " and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        Then I verify the response status code as "200"

    # *************************************************
    #              HAPPY PATH SCENARIOS
    # *************************************************

    # IPC Service - /ipcservice/api/v1/applications
    @happyPath  @TestCaseKey=CAO-T830
    Scenario: IPC Create Application service and verify the application is created in RAS :HTTP 201
        Given I set "POST" method for "CreateApplication"
        And I set the "CreateApplication" request body
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | appId | global | appId |
        When I send the request
        Then I verify the response status code as "201"
        And I verify the complete response body should be "ApplicationCreated"
        And I call GET method for "RAS_GetApplication" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_application_appId                                   | {appId}            |
            | RAS_application_journeyId                               | {x-journey-id}     |
            | RAS_application_statusCode                              | Initiated          |
            | RAS_application_statusReason                            | ApplicationCreated |
            | RAS_application_errors                                  | null               |
            | RAS_application_isJoint                                 | false              |
            | RAS_application_applicantType                           | Single             |
            | RAS_application_applicant_matchStatus                   | UnKnown            |
            | RAS_application_applicantId                             | {applicantId}      |
            | RAS_application_applicant_identityCheckMode             | Unknown            |
            | RAS_application_applicant_impersonationCheckMode        | Unknown            |
            | RAS_application_journeyType                             | Authenticated      |
            | RAS_application_channelInfo_originatingChannel          | INTERNET           |
            | RAS_application_channelInfo_sourceSystemId              | EDB                |
            | RAS_application_channelInfo_businessTxCommChannel       | .CO.UK             |
            | RAS_application_channelInfo_functionalUnit              | 0572               |
            | RAS_application_channelInfo_distributionChannelTypeCode | CODE               |
            | RAS_application_existingProducts                        | null               |
            | RAS_application_applicationState_state1                 | Started            |
            | RAS_application_applicationState_state2                 | ApplicantAdded     |
        And I verify the following param value is "api_exist" with response param value
            | RAS_application_lastUpdatedOn | currentDate |
            | RAS_application_createdOn     | currentDate |
            | RAS_application_createdAt     | currentDate |
        And I call GET method for "RAS_GetApplicant" with required headers and send the request
        And I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | RAS_applicant_applicantId | {applicantId}       |
            | RAS_applicant_isActive    | false               |
            | RAS_applicant_isDeceased  | false               |
            | RAS_applicant_revision    | {applicantRevision} |
        And I verify the following param value is "api_exist" with response param value
            | RAS_applicant_createdAt | currentDate |

    # *************************************************
    #             ERROR SCENARIOS
    # *************************************************

    # *************************************************************
    #    Header/Query/Path Parameter Field Validation
    # *************************************************************

    @error   @401   @TestCaseKey=CAO-T831
    Scenario: IPC Create Application service when authorisation token is not provided: HTTP 401
        Given I set "POST" method for "CreateApplication"
        And I set the "CreateApplication" request body
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id |  |
        And I modify the following param values in the current request body
            | appId | global | appId |
        When I send the request
        Then I verify the response status code as "401"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 401                                                   |
            | Response_error_type    | BusinessException                                     |
            | Response_error_retry   | false                                                 |
            | Response_error_message | Authorization is not available or can not be verified |

    @error   @401   @TestCaseKey=CAO-T832
    Scenario: IPC Create Application service when invalid authorisation token is provided: HTTP 401
        Given I set "POST" method for "CreateApplication"
        And I set the "CreateApplication" request body
        And I set the config for the request to "default"
        And I "update" the following global values
            | jwt | hfysdgfsd |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | appId | global | appId |
        When I send the request
        Then I verify the response status code as "401"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 401                                                   |
            | Response_error_type    | BusinessException                                     |
            | Response_error_retry   | false                                                 |
            | Response_error_message | Authorization is not available or can not be verified |

    @error   @400   @TestCaseKey=CAO-T833
    Scenario: IPC Create Application service when journey id header is not provided: HTTP 400
        Given I set "POST" method for "CreateApplication"
        And I set the "CreateApplication" request body
        And I set the config for the request to "default"
        And I set the headers for the request
            | Authorization |  |
        And I modify the following param values in the current request body
            | appId | global | appId |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                             |
            | Response_error_type    | BusinessException               |
            | Response_error_retry   | false                           |
            | Response_error_message | Missing x-journey-id in request |

    @error   @400   @TestCaseKey=CAO-T834
    Scenario: IPC Create Application service when invalid journey id header is provided: HTTP 400
        Given I set "POST" method for "CreateApplication"
        And I set the "CreateApplication" request body
        And I set the config for the request to "default"
        And I "update" the following global values
            | x-journey-id | hfysdgfsd |
        And I set the headers for the request
            | x-journey-id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | appId | global | appId |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                    |
            | Response_error_type    | BusinessException                      |
            | Response_error_retry   | false                                  |
            | Response_error_message | Valid x-journey-id required in request |

    # *************************************************************
    #    Request Body Field Validation
    # *************************************************************

    @error   @400   @TestCaseKey=CAO-T835
    Scenario: IPC Create Application service when invalid App Id is provided: HTTP 400
        Given I set "POST" method for "CreateApplication"
        And I set the "CreateApplication" request body
        And I set the config for the request to "default"
        And I "update" the following global values
            | appId | hfysdgfsd |
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | appId | global | appId |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                             |
            | Response_error_type    | BusinessException               |
            | Response_error_retry   | false                           |
            | Response_error_message | Valid AppId required in request |

    @error   @400   @TestCaseKey=CAO-T836
    Scenario: IPC Create Application service when App Id is missing from the request payload: HTTP 400
        Given I set "POST" method for "CreateApplication"
        And I set the "CreateApplication" request body
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | appId | remove | Request_createApplication_appId |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                      |
            | Response_error_type    | BusinessException        |
            | Response_error_retry   | false                    |
            | Response_error_message | Missing AppId in request |

    @error   @400   @TestCaseKey=CAO-T837
    Scenario: IPC Create Application service when Original product Id is not provided: HTTP 400
        Given I set "POST" method for "CreateApplication"
        And I set the "CreateApplication" request body
        And I set the config for the request to "default"
        And I set the headers for the request
            | x-journey-Id  |  |
            | Authorization |  |
        And I modify the following param values in the current request body
            | originalProductID | remove | Request_createApplication_originalProductId |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                  |
            | Response_error_type    | BusinessException                    |
            | Response_error_retry   | false                                |
            | Response_error_message | Missing OriginalProductID in request |