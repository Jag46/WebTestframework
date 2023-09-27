@api @regression @ipc
Feature: Scenarios other Apigee endpoints

Background: Generate Authorisation Bearer token for use in apigee calls
        Given I generate a JWT token for token handler exchange requests that origination from "OLB" for this cis number "1711111"
        And I verify the response status code as "200"
        And I generate a token for appIdGen apptype "OLB", productId "7002", new productId "7006", account number "123456 12345678" and environmnet "dev4"
        And I verify the response status code as "302"
        And I generate an authorization bearer token for apigee calls, productId "7002"
        And I verify the response status code as "200"