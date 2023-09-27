import { Given, Then, When } from "@cucumber/cucumber"
import checkYourDetailsPage from "../../pageobjects/2.checkYourDetails.page.js";
import genericPage from '../../pageobjects/genericPage.page';
import coreLib from "../../utilities/coreLibrary"
const fs = require("fs-extra");

/******************
 * Action Steps
 ******************/

When(/^I select "(.*)" for Are Your Details Correct$/, option => {
  if (option.toLowerCase() === "yes") {
    checkYourDetailsPage.selectYesRadioButton();
  } else if (option.toLowerCase() === "no") {
    checkYourDetailsPage.selectNoRadioButton();
  }
});

Then(/^I navigate from Check Your Details page to the Your Tax page by selecting "Yes"$/,{ wrapperOptions: { retry: 2 } }, ()=>{
  checkYourDetailsPage.navigationToYourTaxPage();
});

/******************
 * Validation Steps
 ******************/

Then(/^I validate the content of the check your details page$/, () => {
  checkYourDetailsPage.contentValidation();
});

Then(/^I verify the fields got pre-populated on the check your details page$/, () =>{
  checkYourDetailsPage.prepopulatedFieldsValidation();
});

Then(/^I verify the contact and address details for "(.*)"$/, (scenario) => {
  checkYourDetailsPage.contactAndAddressValidation(scenario);
});

Then(/^validate your contact details "(.*)", "(.*)", "(.*)", "(.*)", "(.*)", "(.*)", "(.*)"$/, (title, firstName,
  lastName, dateOfBirth, email, mobileNo, landlineNo) => {
    checkYourDetailsPage.yourContactDetailsValidation(title, firstName,
    lastName, dateOfBirth, email, mobileNo, landlineNo);
})

Then(/^validate address details "(.*)", "(.*)", "(.*)", "(.*)"$/, (addrLine1, addrLine2, addrLine3, addrLine4) => {
  checkYourDetailsPage.yourAddressValidation(addrLine1, addrLine2, addrLine3, addrLine4);
})


Then(/^validate choose an option error$/, () => {
  checkYourDetailsPage.errorMessageValidation();
});



