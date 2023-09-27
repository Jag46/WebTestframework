import { Given, When, Then } from "@cucumber/cucumber";
import endScreenPage from "../../pageobjects/9.endScreen.page";
import endScreenContent from "../../contents/endScreenContent";
import coreLibrary from "../../utilities/coreLibrary";

/******************
 * Action Steps
 ******************/

Then(/^I click "(.*)" hyperlink on end screen page and validate the url in new tab$/, (hyperlink) => {
    switch (hyperlink.toLowerCase()) {
        case "downlodbankApp":
            coreLibrary.click(endScreenPage.downlodBankAppButton);
            expect(endScreenPage.validateHyperlink(endScreenContent.downlodBankAppLink)).to.equal(true);
            break;
        case "faq":
            coreLibrary.click(endScreenPage.faqHyperlink);
            expect(endScreenPage.validateHyperlink(endScreenContent.faqLink)).to.equal(true);
            break;
    }
    endScreenPage.switchBackToEndScreenWindow();
});

/******************
 * Validation Steps
 ******************/

Then(/^I validate the content on end screen page before 3 mins over$/, () => {
    endScreenPage.genericContentsValidation();
    endScreenPage.contentValidationBeforeThreeMins();
});

Then(/^I validate the content on end screen page after 3 mins over$/,{timeout: 100 * 3000}, () => {
    endScreenPage.contentValidationAfterThreeMins();
    endScreenPage.genericContentsValidation();
});