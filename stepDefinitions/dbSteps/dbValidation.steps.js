import { Given, When, Then } from "@cucumber/cucumber";
let userData = require("../../utilities/globalTestData.js");

Then(
  /^I should see the applicant current state "(.*)" stored in appstore$/,
  currentState => {
    var dbResponse = userData.getField("dbResponse");

    //CurrentState
    assert.equal(
      currentState,
      dbResponse.state,
      "Expected and Actual Current State is not equal"
    );
  }
);

Then(/^I should see the applicantion Id stored in appstore$/, () => {
  var applicationId = userData.getField("applicationId");
  var dbResponse = userData.getField("dbResponse");

  //Customer Number
  assert.equal(
    applicationId,
    dbResponse.applicationId,
    "Expected and Actual applicationId are not equal"
  );
});

Then(
  /^I should see the applicant eContractable device is "(.*)" stored in appstore$/, eContact => {
    var dbResponse = userData.getField("dbResponse");

    //EContractable Device
    assert.equal(
      JSON.parse(eContact),
      dbResponse.ClientSystemInformation.EContractingDeviceCapabilities
        .IsClientDeviceEContractable,
      "Expected and Actual EContractable Device are not equal"
    );
  });

  Then(/^I should see the application data stored in appstore is same as user entered data$/, () => {
    var dbResponse = userData.getField("dbResponse");
    var customerData = userData.getField("customerData");
  
    //Customer Number
    assert.equal(
      applicationId,
      dbResponse.applicationId,
      "Expected and Actual applicationId are not equal"
    );
  });
