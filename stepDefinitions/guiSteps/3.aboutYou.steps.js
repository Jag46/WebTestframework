import { Given, Then, When } from "@cucumber/cucumber"
import aboutYouPage from "../../pageobjects/3.aboutYou.page.js";
import genericPage from '../../pageobjects/genericPage.page';
const fs = require("fs-extra");

/******************
 * Action Steps
 ******************/

When(/^I click "(.*)" I do have another nationality$/, option => {
  if (option.toLowerCase() === "yes") {
    aboutYouPage.selectDoYouHaveAnotherNationalityYes();
  } else if (option.toLowerCase() === "no") {
    aboutYouPage.selectDoYouHaveAnotherNationalityNo();
  }
});

When(/^I select "(.*)" from Nationality dropdown on About you section$/, value => {
  aboutYouPage.selectNationality(value);
});

When(/^I select "(.*)" from Other Nationality dropdown on About you section$/, (value) => {
  aboutYouPage.selectSecondNationality(value);
});

Then(/^I select "(.*)" from Country of birth dropdown on About you section$/, value => {
  aboutYouPage.selectCountryOfBirth(value);
});

Then(/^I navigate from About You page to the Your Tax page by selecting "(.*)" and "(.*)"$/, (value1, value2) => {
  aboutYouPage.selectCountryOfBirth(value1);
  aboutYouPage.selectNationality(value2);
  //aboutYouPage.selectDoYouHaveAnotherNationalityNo();
  aboutYouPage.selectDoYouHaveAnotherNationalityNo();
  genericPage.clickContinueButton()
});

Then(/^I navigate from About You page to the Your Tax page$/,{ wrapperOptions: { retry: 2 } }, () => {
  aboutYouPage.navigateToYourTaxPage();
});



/******************
 * Validation Steps
 ******************/

Then(/^content on page should match the expected content$/, () => {
  aboutYouPage.contentValidation();
});

When(/^validate the country of birth dropdown$/, () => {
  aboutYouPage.validateCountryOfBirthList();
});

When(/^validate the nationality dropdown$/, () => {
  aboutYouPage.validateNationalityList();
});

When(/^validate the other nationality dropdown$/, () => {
  aboutYouPage.validateSecondNationalityList();
});

Then(/^errors on page should match the expected error messages$/, () => {
  aboutYouPage.errorMessageHeaderValidation();
});

Then(/^Validate same nationality selected error message$/, () =>{
  aboutYouPage.validateSameNationalityErrorMessage();
});

Then(/^Validate same nationality selected alert message$/, () =>{
  aboutYouPage.validateSameNationalityAlertMessage();
});

Then(/^alerts on page should match the expected alert messages$/, () => {
  aboutYouPage.errorAlertMessageValidation();
});

