import { Given, Then, When } from "@cucumber/cucumber"
import technicalErrorPage from "../../pageobjects/ipcError.page.js";
import globalTestData from "../../utilities/globalTestData.js";
import coreLib from "../../utilities/coreLibrary";
import { expect } from "chai";

/**
 * Define techincal Error Screen steps
 */

Then(/^I validate the technical error page$/, () => {
  technicalErrorPage.validateFieldsTechnicalErrorPage();
});

/**
 * Define generic Error Screen steps
 */

 Then(/^I validate the generic error page$/, () => {
  technicalErrorPage.validateGenericErrorPage();
});

/**
 * Define ID Status Error Screen steps
 */

Then(/^I validate the ID status error page$/, () => {
  technicalErrorPage.validateIdStatusErrorPage();
});

/**
 * Define Overdrawn Error Screen steps
 */

Then(/^I validate the overdrawn error page$/, () => {
  technicalErrorPage.validateOverdrawnErrorPage();
});

/**
 * Define Technical issue Error Screen steps
 */

Then(/^I validate the technical issue error page$/, () => {
  technicalErrorPage.validateTechIssueErrorPage();
});

/**
 * Define Incorrect details Error Screen steps
 */

Then(/^I validate the incorrect details error page$/, () => {
  technicalErrorPage.validateIncorrectDetailsErrorPage();
});

/**
 * Define joint account browser Error Screen steps
 */

Then(/^I validate the joint Account browser error page$/, () => {
  technicalErrorPage.validateJointAccountBrowserErrorPage();
});

/**
 * Define joint account app Error Screen steps
 */

Then(/^I validate the joint Account app error page$/, () => {
  technicalErrorPage.validateJointAccountAppErrorPage();
});

/**
 * Define No Account Found Error Screen steps
 */

Then(/^I validate the No Accounts Found error page$/, () => {
  technicalErrorPage.validateNoAccountsFoundErrorPage();
});

/**
 * Define Landing Error Screen steps
 */

Then(/^I validate the Landing page error page$/, () => {
  technicalErrorPage.validateLandingPageErrorPage();
});

/**
 * Define Email Bounce Back Error Screen steps
 */

Then(/^I validate the email bounce back error page$/, () => {
  technicalErrorPage.validateEmailBounceBackErrorPage();
});

/**
 *  Define Product Change (End screen) Error Screen steps
 */

Then(/^I validate the Product Change error page$/, () => {
  technicalErrorPage.validateProductChangeErrorPage();
});