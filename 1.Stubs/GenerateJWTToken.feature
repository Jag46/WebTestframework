@api @regression @ipc
Feature: Scenarios for generate JWT Token stub

    # *************************************************
    #              HAPPY PATH SCENARIOS
    # *************************************************
    
    Scenario: Generate JWT token for parameterised scenario
        Given I set "GET" method for "generateJWT"
        And I set the config for the request to "default"
        And I set the path paramters for a request
            | cisnumber | 234567833 |
        And I set the query parameters for the request
            | apptype | OLB |
        When I send the request
        Then I verify the response status code as "200"


# *************************************************
#              ERROR SCENARIOS
# *************************************************


# *************************************************
#              HEADERS ERROR SCENARIOS
# mandatory or optional Headers remove/empty/null values
# *************************************************



#*************************************************
#             REQUEST PAYLOAD
# mandatory or optional body remove/empty/null values
# *************************************************



#*************************************************
#                Miscellaneous
#             and Invlid EndPontURL
# *************************************************

#*************************************************
#             MAX Length Headder AND Body
# *************************************************


#*************************************************
#             ANTISAMY
#   Body or Headder having scripts
# *************************************************


#*************************************************
#HEADER & BODY SPECIAL CHARACTERS VALIDATIONS
# *************************************************

#*************************************************
#           E2E Scenarios
# *************************************************
