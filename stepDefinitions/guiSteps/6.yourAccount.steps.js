import { Given, When, Then } from "@cucumber/cucumber";
import yourAccountPage from "../../pageobjects/6.yourAccount.page.js";


/******************
 * Action Steps
 ******************/
Then(/^I click the back to Your Account Change link on top of the page$/, () => {
  yourAccountPage.clickBackButton();
});

Then(/^I select the checkbox for I would like a chequebook$/, () => {
  yourAccountPage.selectCheckbookCheckBox();
});

Then(/^I verify the fields got pre-populated on your account page when chequeBook required (.*)$/, (value) => {
  if(value.toLowerCase()==='false'){
    yourAccountPage.prepopulatedFieldsValidationForNo();
  }else if(value.toLowerCase()==='true'){
    yourAccountPage.prepopulatedFieldsValidationForYes();
  }
});

Then(
  /^I select "(.*)" radiobutton to contact via "(.*)" as marketing preference$/,
  (option, contact) => {
    if (contact.toLowerCase() === "emails") {
      if (option.toLowerCase() === "yes") {
        yourAccountPage.selectMarketingPrefEmailYes();
      } else if (option.toLowerCase() === "no") {
        yourAccountPage.selectMarketingPrefEmailNo();
      }
    } else if (contact.toLowerCase() === "letters") {
      if (option.toLowerCase() === "yes") {
        yourAccountPage.selectMarketingPrefLetterYes();
      } else if (option.toLowerCase() === "no") {
        yourAccountPage.selectMarketingPrefLetterNo();
      }
    } else if (contact.toLowerCase() === "calls") {
      if (option.toLowerCase() === "yes") {
        yourAccountPage.selectMarketingPrefTelehoneYes();
      } else if (option.toLowerCase() === "no") {
        yourAccountPage.selectMarketingPrefTelehoneNo();
      }
    }
  }
);

Then(/^I select "(.*)" radiobutton for all marketing preference$/, (option) => {
  if (option.toLowerCase() === "yes") {
    yourAccountPage.selectMarketingPrefEmailYes();
    yourAccountPage.selectMarketingPrefLetterYes();
    yourAccountPage.selectMarketingPrefTelehoneYes();
  } else if (option.toLowerCase() === "no") {
    yourAccountPage.selectMarketingPrefEmailNo();
    yourAccountPage.selectMarketingPrefLetterNo();
    yourAccountPage.selectMarketingPrefTelehoneNo();
  }
});

Then(/^I navigate from Check Your Details page to the Important Information page$/,{ wrapperOptions: { retry: 2 } }, () => {
  yourAccountPage.navigationToImportantInformationPage();
});

Then(/^Navigate from Check Your Details page to Your Account page$/,{ wrapperOptions: { retry: 2 } }, () => {
  yourAccountPage.navigationToYourAccountPage();
});
/******************
 * Validation Steps
 ******************/
Then(/^I validate the content of the your account page$/, () => {
  yourAccountPage.contentValidation();
});

Then(
  /^I validate the error for "(.+)" marketing preference not selected$/,
  (number) => {
    switch (number) {
      case "three":
        yourAccountPage.verifyNoMarketingPrefSelectedError();
        break;

      case "two":
        yourAccountPage.verifyTwoOfMarketingPrefSelectedError();
        break;

      case "one":
        yourAccountPage.verifyOnly1MarketingPrefSelectedError();
        break;
    }
  }
);