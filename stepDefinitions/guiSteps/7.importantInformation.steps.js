import { Given, When, Then } from "@cucumber/cucumber";
import importantInformationPage from "../../pageobjects/7.importantInformation.page";
import importantInformationContent from "../../contents/importantInformationContent";

import coreLibrary from "../../utilities/coreLibrary";

/******************
 * Validation Steps
 ******************/

Then(
  /^I validate the content of the important information page for account "(.*)" overdraft$/,
  (overdraftFlag) => {
    if (overdraftFlag == "with") {
      importantInformationPage.pageContentValidation();
      importantInformationPage.pageLinksContentValidation();
      importantInformationPage.modalbuttonContentValidation();
    }
    else if (overdraftFlag == "without") {
        importantInformationPage.pageContentValidationWithoutOD();
        importantInformationPage.pageLinksContentValidationWithoutOD();
        importantInformationPage.modalbuttonContentValidationWithoutOD();
      }
  }
);

Then(/^I validate error links displayed at header on important information page$/, () => {
     importantInformationPage.errorLinkMessagesValidation();
});

Then(/^I validate error messages displayed at field level on important information page$/, () => {
     importantInformationPage.errorAlertMessagesValidation();
});

/******************
 * Action Steps
 ******************/

When(/^I click the back to Your Account page link on top of the page$/, () => {
    importantInformationPage.clickBackButton();
});

When(/^I click the terms and conditions button and agree the modal on the page$/, ()=>{
    importantInformationPage.agreeTermsAndConditionsModal();
})

When(/^I click the PCCI button and agree the modal on the page$/, ()=>{
    importantInformationPage.agreePCCIModal();
})

Then(/^I click "(.*)" hyperlink on the page and validate the url in new tab$/, (hyperlink) => {
    switch (hyperlink.toLowerCase()) {
        case "ratesandcharges":
            coreLibrary.click(importantInformationPage.ratesAndChargesLink)
            expect(importantInformationPage.validateHyperlink(importantInformationContent.ratesAndChargesHyperlink)).to.equal(true);
            break;
        case "nationwiderules":
            coreLibrary.click(importantInformationPage.nationwideRulesLink)
            expect(importantInformationPage.validateHyperlink(importantInformationContent.nationwideRulesHyperlink)).to.equal(true);
            break;
        case "feeInformationdocument":
            coreLibrary.click(importantInformationPage.feeInformationDocumentLink)
            expect(importantInformationPage.validateHyperlink(importantInformationContent.feeInformationDocumentHyperlink)).to.equal(true);
            break;
        case "fscsdocument":
            coreLibrary.click(importantInformationPage.FSCSDocumentLink)
            expect(importantInformationPage.validateHyperlink(importantInformationContent.fscsDocumentHyperlink)).to.equal(true);
            break;
        case "charitableassignment":
            coreLibrary.click(importantInformationPage.charitableAssignmentLink)
            expect(importantInformationPage.validateHyperlink(importantInformationContent.charitableAssignmentHyperlink)).to.equal(true);
            break;
    }
    importantInformationPage.switchBackToImportantInformationWindow();
});

Then(/^I click "(.*)" modal on the page and validate the button functionality on modal$/, (modal) => {
    switch (modal.toLowerCase()) {
        case "arrangedoverdraftagreement":
            importantInformationPage.arrangedOverdraftAgreementModalButtonsActions();
            break;
        case "pccidocument":
            importantInformationPage.pcciModalButtonsActions();
            break;
        case "termsandconditions":
            importantInformationPage.tncModalButtonsActions();
            break;
    }    
});

Then(/^I click the terms and conditions button and I disagree the tnc modal on the page$/, () => {
    importantInformationPage.disagreeTermsAndConditionsModal();
});

Then(/^I click the pcci document modal button and I close the pcci modal on the page$/, () => {
    importantInformationPage.closePCCIModal();
});