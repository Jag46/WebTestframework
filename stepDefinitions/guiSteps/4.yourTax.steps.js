import { Given, Then, When } from "@cucumber/cucumber"
import yourTaxPage from "../../pageobjects/4.yourTax.page.js";
const fs = require("fs-extra");

/******************
 * Action Steps
 ******************/

When(/^I select "(.*)" for Are you liable to pay tax in any other country$/, option => {
  if (option.toLowerCase() === "yes") {
    yourTaxPage.selectYesLiableQueRadio();
  } else if (option.toLowerCase() === "no") {
    yourTaxPage.selectNoLiableQueRadio();
  }
});

When(/^I select "(.*)" for Are you a citizen of the United States of America$/, option => {
  if (option.toLowerCase() === "yes") {
    yourTaxPage.selectYesCitizenQueRadio();
  } else if (option.toLowerCase() === "no") {
    yourTaxPage.selectNoCitizenQueRadio();
  }
});

When(/^I select "(.*)" from the "(.*)" other country dropdown$/, (value, countryNumber)  => {
  if (countryNumber.toLowerCase() === "first") {
    yourTaxPage.otherCountryOne(value);
  } else if (countryNumber.toLowerCase() === "second") {
    yourTaxPage.otherCountryTwo(value);
  } else if (countryNumber.toLowerCase() === "third") {
    yourTaxPage.otherCountryThree(value);
  }
    
});

When(/^I select "(.*)" for Are you a resident for tax in any country other than the United Kingdom$/, option => {
  if (option.toLowerCase() === "yes") {
    yourTaxPage.selectYesTaxPayOtherCountryRadio();
  } else if (option.toLowerCase() === "no") {
    yourTaxPage.selectNoTaxPayOtherCountryRadio();
  }
});

When(/^I enter "(.*)" in TIN number issued for "(.*)"$/, (option1, option2) => {
  if (option2.toLowerCase() === "us") {
    yourTaxPage.setTINForUS(option1);
  } else if (option2.toLowerCase() === "country one") {
    yourTaxPage.setINForCountryOne(option1);
  } else if (option2.toLowerCase() === "country two") {
    yourTaxPage.setINForCountryTwo(option1);
  }else if (option2.toLowerCase() === "country three") {
    yourTaxPage.setINForCountryThree(option1);
  }
});

Then(/^I click the Add another country button in yourTax page "(.*)"$/, (value) => {
  if (value.toLowerCase() === "once") {
    yourTaxPage.clickAddAnotherCountryButton();
  } else if (value.toLowerCase() === "twice") {
  yourTaxPage.clickAddAnotherCountryButton();
  yourTaxPage.clickAddAnotherCountryButton();
  } 
});

Then(/^I type "(.*)" into the country field$/, (value) => {
  yourTaxPage.setPartialValueOnCountryOne(value)
});

Then(/^I validate the number of returned values in the country field equals (-?\d+)$/, (value) => {
  yourTaxPage.validateNumberOfReturnedValuesInCountryDropdownOne(value)
});

Then(/^I validate the error for no matching countries$/, () => {
  yourTaxPage.validateNoCountryMatchError()
});

Then(/^I navigate from Your Tax page to the Your Account Change page$/,{ wrapperOptions: { retry: 2 } }, () => {
  yourTaxPage.navigationToYourAccountChangePage();
});

/******************
 * Validation Steps
 ******************/

 Then(/^I validate the content of the Your Tax page$/, () => {
  yourTaxPage.validateContent();
});

Then(/^I verify the fields got pre-populated on your tax page for liable to pay tax selected "(.*)"$/, (value) => {
  if (value.toLowerCase() === "no"){
    yourTaxPage.prepopulatedFieldsValidationForNo();
  }else if(value.toLowerCase() === "yes"){
    yourTaxPage.prepopulatedFieldsValidationForYes();
  }
});

 Then(/^validate the error message for "(.*)"$/, (value) => {
  if (value.toLowerCase() === "unselected tax liable") {
    yourTaxPage.validateUnselectedLiableForTaxError();
  } else if (value.toLowerCase() === "residency tax") {
    yourTaxPage.validateSelectedNoResidentForTaxPurposeError();
  } else if (value.toLowerCase() === "skip question 2 and 3") {
    yourTaxPage.validateUnselectedUSCitizenError()
    yourTaxPage.validateUnselectedTaxResidentError()
  } else if (value.toLowerCase() === "invalid tin text") {
    yourTaxPage.validateInvalidTinError()
  } else if (value.toLowerCase() === "too long tin text") {
    yourTaxPage.validateTooLongTinError()
  } else if (value.toLowerCase() === "additional countries selected") {
    yourTaxPage.validateUnselectedAdditionalCountryErrors()
  } else if (value.toLowerCase() === "additional us country") {
    yourTaxPage.validateAdditionalCountryEqualsUSError()
  } else if (value.toLowerCase() === "other countries are the same") {
    yourTaxPage.validateOytherCountriesAreTheSameError()
  }
});


