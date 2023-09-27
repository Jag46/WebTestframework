import { Given, When, Then } from "@cucumber/cucumber";
import accountSelectionPage from "../../pageobjects/2.accountSelection.page.js";

/******************
 * Action Steps
 ******************/

 Then(/^I select account number "(.*)"$/, (account) => {
    accountSelectionPage.accountSelection(account);
});

/******************
 * Validation Steps
 ******************/

 Then(/^Account selection spinner should be displayed$/, () => {
    accountSelectionPage.verifyAccountSelectionInterstitialTest();
    accountSelectionPage.verifyFinalAccountSelectionInterstitialText();
});

Then(/^I validate the content of the account selection page$/, () => {
    accountSelectionPage.verifyContentOnPage();
});

Then(/^I validate the no account selected error$/, () => {
    accountSelectionPage.verifyNoAccountSelectedError();
});