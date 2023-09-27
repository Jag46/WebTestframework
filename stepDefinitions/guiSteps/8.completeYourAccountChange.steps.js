import { Given, When, Then } from "@cucumber/cucumber";
import completeYourAccountChangePage from "../../pageobjects/8.completeYourAccountChange.page";
import genericPage from "../../pageobjects/genericPage.page";

/******************
 * Action Steps
 ******************/
Then(/^I click the back to Important Information link on top of the page$/, () => {
    completeYourAccountChangePage.clickBackButton();
});

Then(/^I click the Complete Account Change Button$/, () => {
    completeYourAccountChangePage.clickCompleteAccountChangeButton();
});

Then(/^I click the complete your account change button$/, { wrapperOptions: { retry: 2 } }, () => {
    genericPage.clickCompleteAccountChangeButton();
});
  
Given(/^I navigate from Check Your Details page to Complete Your Account Change page$/, () => {
    completeYourAccountChangePage.navigationToCompleteAccountChangePage();
});

Given(/^I navigate from Check Your Details page to Complete Your Account Change page via yourTax Page$/, () => {
    completeYourAccountChangePage.navigationToCompleteAccountChangePageViaTaxPage();
});

/******************
 * Validation Steps
 ******************/
Then(/^I validate the content on complete your account change page$/, () => {
    completeYourAccountChangePage.contentValidation();
});