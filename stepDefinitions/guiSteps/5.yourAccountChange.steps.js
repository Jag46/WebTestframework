import { Given, When, Then } from "@cucumber/cucumber";
import yourAccountChangePage from "../../pageobjects/5.yourAccountChange.page";
import coreLib from "../../utilities/coreLibrary";
import YourAccountChangeContent from "../../contents/yourAccountChangeContent";
import CheckYourDetailsPage from "../../pageobjects/2.checkYourDetails.page";
import YourTaxPage from "../../pageobjects/4.yourTax.page";

/******************
 * Action Steps
 ******************/
Then(/^I click the back to Your tax link on top of the page$/, () => {
    yourAccountChangePage.clickBackButton();
});

Then(/^I click the back to Check your details link on top of the page$/, () => {
    yourAccountChangePage.clickBackButton();
});

Then(/^I navigate from Your Account Change page to the Your Account page$/,{ wrapperOptions: { retry: 2 } }, () => {
    yourAccountChangePage.navigationToYourAccountPage();
});

Then(/^I navigate from Check Your Details page to Your Account change page$/,{ wrapperOptions: { retry: 2 } }, () => {
    CheckYourDetailsPage.navigationToYourAccountChange();
});

Then(/^I navigate from Your Tax page to Your Account change page$/,{ wrapperOptions: { retry: 2 } }, () => {
    YourTaxPage.navigationToYourAccountChangePage();
});

/******************
 * Validation Steps
 ******************/
Then(/^I validate the content on the your account change page when account overdraft is "(.*)"$/, (value) => {
    switch (value.toLowerCase()) {
        case "greaterthanzero":
            yourAccountChangePage.contentValidation();
            let accountBenefitsMessage1 = coreLib.getText(yourAccountChangePage.accountBenefitsMessage);
            expect(accountBenefitsMessage1).to.equal(YourAccountChangeContent.accountBenefitOverdraftGreaterThanZero);
            break;
        case "lessthanzero":
            yourAccountChangePage.contentValidation();
            let accountBenefitsMessage2 = coreLib.getText(yourAccountChangePage.accountBenefitsMessage);
            expect(accountBenefitsMessage2).to.equal(YourAccountChangeContent.accountBenefitOverdraftLessThanZero);
            break;
    }
});