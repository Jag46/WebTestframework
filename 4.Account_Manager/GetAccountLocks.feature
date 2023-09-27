@api @regression @ipc
Feature: Scenarios for Account Manager- Get Account Locks end point
    # Account Manager - /account-setup/v1/Account/GetAccountLocks

    Background: Generate JWT for use in token handler calls
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1711111"
        And I verify the response status code as "200"

    # *************************************************
    #              HAPPY PATH SCENARIOS
    # *************************************************

    @happyPath  @TestCaseKey=CAO-T634
    Scenario: Get Account Locks for an account with lock that is not being actioned by IPC: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100044 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100044 12345678 |
            | Response_accountLock_Code         | 001044          |
            | Response_accountLock_Description  | Freeze Charges  |

    # *************************************************
    #              ERROR SCENARIOS
    # *************************************************

    # *************************************************
    #             Account Lock Pre-Check
    # *************************************************

    @EligibilityFailure  @TestCaseKey=CAO-T633
    Scenario: Get Account Locks for account with code 001001: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100001 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100001 12345678   |
            | Response_accountLock_Code         | 001001            |
            | Response_accountLock_Description  | SID Account Block |

    @EligibilityFailure  @TestCaseKey=CAO-T656
    Scenario: Get Account Locks for an account with lock code 001002: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100002 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100002 12345678 |
            | Response_accountLock_Code         | 001002          |
            | Response_accountLock_Description  | Suspect Account |

    @EligibilityFailure  @TestCaseKey=CAO-T657
    Scenario: Get Account Locks for an account with lock code 001003: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100003 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100003 12345678      |
            | Response_accountLock_Code         | 001003               |
            | Response_accountLock_Description  | Head Office Referral |

    @EligibilityFailure  @TestCaseKey=CAO-T660
    Scenario: Get Account Locks for an account with lock code 001004: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100004 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100004 12345678         |
            | Response_accountLock_Code         | 001004                  |
            | Response_accountLock_Description  | No Withdrawals (legacy) |

    @EligibilityFailure  @TestCaseKey=CAO-T661
    Scenario: Get Account Locks for an account with lock code 001005: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100005 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100005 12345678          |
            | Response_accountLock_Code         | 001005                   |
            | Response_accountLock_Description  | Customer Bankrupt (sole) |

    @EligibilityFailure  @TestCaseKey=CAO-T662
    Scenario: Get Account Locks for an account with lock code 001006: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100006 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100006 12345678           |
            | Response_accountLock_Code         | 001006                    |
            | Response_accountLock_Description  | Customer Bankrupt (joint) |

    @EligibilityFailure  @TestCaseKey=CAO-T663
    Scenario: Get Account Locks for an account with lock code 001007: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100007 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100007 12345678    |
            | Response_accountLock_Code         | 001007             |
            | Response_accountLock_Description  | No Withdrawals SID |

    @EligibilityFailure  @TestCaseKey=CAO-T664
    Scenario: Get Account Locks for an account with lock code 001008: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100008 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100008 12345678                |
            | Response_accountLock_Code         | 001008                         |
            | Response_accountLock_Description  | No Withdrawals (Lending Ctrl.) |

    @EligibilityFailure  @TestCaseKey=CAO-T665
    Scenario: Get Account Locks for an account with lock code 001009: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100009 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100009 12345678    |
            | Response_accountLock_Code         | 001009             |
            | Response_accountLock_Description  | Account in Dispute |

    @EligibilityFailure  @TestCaseKey=CAO-T666
    Scenario: Get Account Locks for an account with lock code 001011: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100011 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100011 12345678       |
            | Response_accountLock_Code         | 001011                |
            | Response_accountLock_Description  | Unathorised Borrowing |

    @EligibilityFailure  @TestCaseKey=CAO-T667
    Scenario: Get Account Locks for an account with lock code 001012: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100012 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100012 12345678    |
            | Response_accountLock_Code         | 001012             |
            | Response_accountLock_Description  | Termination Bundle |

    @EligibilityFailure  @TestCaseKey=CAO-T668
    Scenario: Get Account Locks for account with code 001013: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100013 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100013 12345678           |
            | Response_accountLock_Code         | 001013                    |
            | Response_accountLock_Description  | Account Forced Downgraded |

    @EligibilityFailure  @TestCaseKey=CAO-T669
    Scenario: Get Account Locks for an account with lock code 001017: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100017 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100017 12345678                |
            | Response_accountLock_Code         | 001017                         |
            | Response_accountLock_Description  | Court of Protection Card Restr |

    @EligibilityFailure  @TestCaseKey=CAO-T670
    Scenario: Get Account Locks for an account with lock code 001018: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100018 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100018 12345678            |
            | Response_accountLock_Code         | 001018                     |
            | Response_accountLock_Description  | UN Sanctions Branch Access |

    @EligibilityFailure  @TestCaseKey=CAO-T671
    Scenario: Get Account Locks for an account with lock code 001019: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100019 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100019 12345678               |
            | Response_accountLock_Code         | 001019                        |
            | Response_accountLock_Description  | UN Sanctions Payment Mandates |

    @EligibilityFailure  @TestCaseKey=CAO-T672
    Scenario: Get Account Locks for an account with lock code 001020: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100020 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100020 12345678               |
            | Response_accountLock_Code         | 001020                        |
            | Response_accountLock_Description  | UN Sanctions Branch & PaymMdt |

    @EligibilityFailure  @TestCaseKey=CAO-T673
    Scenario: Get Account Locks for an account with lock code 001021: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100021 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100021 12345678                |
            | Response_accountLock_Code         | 001021                         |
            | Response_accountLock_Description  | Criminal Financial Court Order |

    @EligibilityFailure  @TestCaseKey=CAO-T674
    Scenario: Get Account Locks for an account with lock code 001022: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100022 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100022 12345678                |
            | Response_accountLock_Code         | 001022                         |
            | Response_accountLock_Description  | Criminal Court Order BranchAcc |

    @EligibilityFailure  @TestCaseKey=CAO-T675
    Scenario: Get Account Locks for an account with lock code 001023: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100023 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100023 12345678               |
            | Response_accountLock_Code         | 001023                        |
            | Response_accountLock_Description  | Criminal Court Order PaymMdts |

    @EligibilityFailure  @TestCaseKey=CAO-T676
    Scenario: Get Account Locks for an account with lock code 001024: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100024 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100024 12345678                |
            | Response_accountLock_Code         | 001024                         |
            | Response_accountLock_Description  | Criminal Court Order Br & PMdt |

    @EligibilityFailure  @TestCaseKey=CAO-T677
    Scenario: Get Account Locks for an account with lock code 001025: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100025 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100025 12345678 |
            | Response_accountLock_Code         | 001025          |
            | Response_accountLock_Description  | UN Sanctions    |

    @EligibilityFailure  @TestCaseKey=CAO-T678
    Scenario: Get Account Locks for an account with lock code 001026: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100026 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100026 12345678   |
            | Response_accountLock_Code         | 001026            |
            | Response_accountLock_Description  | Civil Court Order |

    @EligibilityFailure  @TestCaseKey=CAO-T679
    Scenario: Get Account Locks for an account with lock code 001027: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100027 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100027 12345678            |
            | Response_accountLock_Code         | 001027                     |
            | Response_accountLock_Description  | Civil Court Order w Limits |

    @EligibilityFailure  @TestCaseKey=CAO-T680
    Scenario: Get Account Locks for an account with lock code 001028: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100028 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100028 12345678                |
            | Response_accountLock_Code         | 001028                         |
            | Response_accountLock_Description  | Civil Court Order LargePaymLim |

    @EligibilityFailure  @TestCaseKey=CAO-T681
    Scenario: Get Account Locks for an account with lock code 001046: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100046 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100046 12345678         |
            | Response_accountLock_Code         | 001046                  |
            | Response_accountLock_Description  | No Withdrawals (Retail) |

    @EligibilityFailure  @TestCaseKey=CAO-T682
    Scenario: Get Account Locks for an account with lock code 001073: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100073 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100073 12345678          |
            | Response_accountLock_Code         | 001073                   |
            | Response_accountLock_Description  | No Withdrawals (Collect) |

    @EligibilityFailure  @TestCaseKey=CAO-T683
    Scenario: Get Account Locks for an account with lock code 001078: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100078 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100078 12345678        |
            | Response_accountLock_Code         | 001078                 |
            | Response_accountLock_Description  | Temp UN Sanctions - PH |

    @EligibilityFailure  @TestCaseKey=CAO-T684
    Scenario: Get Account Locks for an account with lock code 001079: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100079 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100079 12345678         |
            | Response_accountLock_Code         | 001079                  |
            | Response_accountLock_Description  | Temp UN Sanctions - NPH |

    @EligibilityFailure  @TestCaseKey=CAO-T685
    Scenario: Get Account Locks for an account with lock code 003002: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 103002 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 103002 12345678 |
            | Response_accountLock_Code         | 003002          |
            | Response_accountLock_Description  | No Trace        |

    @EligibilityFailure  @TestCaseKey=CAO-T686
    Scenario: Get Account Locks for an account with lock code 003003: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 103003 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 103003 12345678        |
            | Response_accountLock_Code         | 003003                 |
            | Response_accountLock_Description  | Customer Deceased Lock |

    @EligibilityFailure  @TestCaseKey=CAO-T635
    Scenario: Get Account Locks details for account with multiple lock codes: HTTP 200
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100999 12345678 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "200"
        And I verify the following param value is "api_equal" with response param value
            | Response_accountManager_accountid | 100999 12345678        |
            | Response_accountLock_Code         | 001044                 |
            | Response_accountLock_Description  | Freeze Charges         |
            | Response_accountLock_Code2        | 001025                 |
            | Response_accountLock_Description2 | UN Sanctions           |
            | Response_accountLock_Code3        | 003003                 |
            | Response_accountLock_Description3 | Customer Deceased Lock |

    # **********************************************************************
    #              Field Level Validation for Header and and query parameters
    # *********************************************************************
    @400    @error  @TestCaseKey=CAO-T636
    Scenario: Call Get Account Locks service with more than maximum length of account number>28: HTTP 400
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100999 1234567899999999999999 |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                                                 |
            | Response_error_type    | BusinessException                                                   |
            | Response_error_retry   | false                                                               |
            | Response_error_message | Invalid account id, check the contract specification for account id |

    @400    @error  @TestCaseKey=CAO-T637
    Scenario: Call Get Account Locks service with special characters in the account number: HTTP 400
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100001 123456787* | accountId | 100001 123456787* | accountId | 100001 123456787* | accountId | 100001 123456787*| accountId | 100001 123456787* | accountId | 100001 123456787*| accountId | 100001 123456787*|accountId|100001 123456787*$&| | |  | |  |  |  |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                                                                 |
            | Response_error_type    | BusinessException                                                   |
            | Response_error_retry   | false                                                               |
            | Response_error_message | Invalid account id, check the contract specification for account id |

    @401  @error    @TestCaseKey=CAO-T638
    Scenario: Call Get Account Locks service without the Authorisation token: HTTP 401
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100001 12345678 |
        When I send the request
        Then I verify the response status code as "401"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 401                              |
            | Response_error_type    | SystemException                  |
            | Response_error_retry   | false                            |
            | Response_error_message | Bad request check request header |

    @400  @error    @TestCaseKey=CAO-T639
    Scenario: Call Get Account Locks service with incorrect Authorisation token: HTTP 400
        Given I set "GET" method for "accountLocks"
        And I set the config for the request to "default"
        And I set the query parameters for the request
            | accountId | 100001 12345678 |
        And I "update" the following global values
            | jwt | hfysdgfsd |
        And I set the headers for the request
            | authorizationtoken |  |
        When I send the request
        Then I verify the response status code as "400"
        And I verify the following param value is "api_equal" with response param value
            | Response_error_code    | 400                              |
            | Response_error_type    | BusinessException                  |
            | Response_error_retry   | false                            |
            | Response_error_message | Bad request check request header / Validation Error - Error while parsing authorization token |