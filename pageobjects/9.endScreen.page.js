import coreLib from "../utilities/coreLibrary";
import EndScreenPageContent from "../contents/endScreenContent";
import { expect } from "chai";


class EndScreenPage {
  /**
   * Define End Screen Page Elements
   */

  get downlodBankAppButton() {
    return $("[data-ref='downlodBankAppLink.link']");
  }

  get faqHyperlink() {
    return $("[data-ref='faqLink.link']");
  }

  get pageHeadingText() {
    return $("[data-ref='pageHeading.heading']");
  }

  get pageSubHeadingText() {
    return $("[data-ref='pageSubHeading.text']");
  }

  get tableHeadingText() {
    return $("[data-ref='cardHeader_Your account details will stay the same.heading']");
  }

  get sortCodeText() {
    return $("[data-ref='Sort code.text']");
  }

  get accountNumberText() {
    return $("[data-ref='Account number.text']");
  }

  get arrangedOverdraftText() {
    return $("[data-ref='Arranged overdraft.text']");
  }

  get finalPageWarningBeforeThreeMins() {
    return $("[data-ref='warningMessageHeading.text']");
  }

  get finalPageWarningAfterThreeMins() {
    return $("[data-ref='warningMessageHeading.text']");
  }

  get warningMessageText() {
    return $("[data-ref='warningMessageText.heading']");
  }

  get nextStepHeading() {
    return $("[data-ref='nextStepHeading.heading']");
  }

  get stepOneText() {
    return $("[data-ref='stepOne']");
  }

  get stepTwoText() {
    return $("[data-ref='stepTwo']");
  }

  get stepThreeText() {
    return $("[data-ref='stepThree']");
  }

  get stepFourText() {
    return $("[data-ref='stepFour']");
  }

  get stepFiveText() {
    return $("[data-ref='stepFive']");
  }

  get noteHeading() {
    return $("[data-ref='noteHeading.heading']");
  }

  get phoneNumberText() {
    return $("[data-ref='phoneNumber.text']");
  }

  get phoneNumberLinkText() {
    return $("[data-ref='phoneNumberLink.link']");
  }

  get faqHeading() {
    return $("[data-ref='faq.heading']");
  }

  get faqText() {
    return $("[data-ref='faqText.text']");
  }

  /******************
   * Action Methods
   ******************/

   isOpen() {
    browser.waitForUrl(
      "https://nbs-banking-webapp-ipc-int.dev4.edb-a.eu-west-2.notprod.thenbs.io/finalscreen",
      10000
    );
    return browser.pageLoaded();
  }

  switchBackToEndScreenWindow() {
    browser.switchWindow(
      "https://nbs-banking-webapp-ipc-int.dev4.edb-a.eu-west-2.notprod.thenbs.io/finalscreen"
    );
  }

  /******************
   * Validation Methods
   ******************/
  genericContentsValidation() {
    let pageHeading = coreLib.getText(this.pageHeadingText);
    expect(pageHeading).to.equal(EndScreenPageContent.pageHeading);
    coreLib.validateCSSProperties(this.pageHeadingText, "rgba(19,19,31,1)", "cabernetjfpro", "h1");
    let pageSubHeading = coreLib.getText(this.pageSubHeadingText);
    expect(pageSubHeading).to.equal(EndScreenPageContent.pageSubHeading);
    coreLib.validateCSSProperties(this.pageSubHeadingText, "rgba(66,66,76,1)", "nbs", "p");
    let nextStepHeading = coreLib.getText(this.nextStepHeading);
    expect(nextStepHeading).to.equal(EndScreenPageContent.nextStepHeading);
    coreLib.validateCSSProperties(this.nextStepHeading, "rgba(19,19,31,1)", "nbs", "h3");
    let stepOneText = coreLib.getText(this.stepOneText);
    expect(stepOneText).to.equal(EndScreenPageContent.stepOneText);
    let stepTwoText = coreLib.getText(this.stepTwoText);
    expect(stepTwoText).to.equal(EndScreenPageContent.stepTwoText);
    let stepThreeText = coreLib.getText(this.stepThreeText);
    expect(stepThreeText).to.equal(EndScreenPageContent.stepThreeText);
    let stepFourText = coreLib.getText(this.stepFourText);
    expect(stepFourText).to.equal(EndScreenPageContent.stepFourText);
    let stepFiveText = coreLib.getText(this.stepFiveText);
    expect(stepFiveText).to.equal(EndScreenPageContent.stepFiveText);
    let downlodBankAppLinkText = coreLib.getText(this.downlodBankAppButton);
    expect(downlodBankAppLinkText).to.equal(EndScreenPageContent.downlodBankAppLinkText);
    let link = coreLib.getAttribute(this.downlodBankAppButton, "href");
    expect(link).to.equal(EndScreenPageContent.downlodBankAppLink);
    let noteHeading = coreLib.getText(this.noteHeading);
    expect(noteHeading).to.equal(EndScreenPageContent.noteHeading);
    coreLib.validateCSSProperties(this.noteHeading, "rgba(19,19,31,1)", "nbs", "h3");
    let phoneNumberText = coreLib.getText(this.phoneNumberText);
    expect(phoneNumberText).to.equal(EndScreenPageContent.phoneNumberText);
    coreLib.validateCSSProperties(this.phoneNumberText, "rgba(66,66,76,1)", "nbs", "p");
    let phoneLinkContent = coreLib.getText(this.phoneNumberLinkText);
    expect(phoneLinkContent).to.equal(EndScreenPageContent.phoneNumberLinkText);
    let phoneLink = coreLib.getAttribute(this.phoneNumberLinkText,"href");
    expect(phoneLink).to.equal(EndScreenPageContent.phoneNumberLink);
    let faqHeading = coreLib.getText(this.faqHeading);
    expect(faqHeading).to.equal(EndScreenPageContent.faqHeading);
    coreLib.validateCSSProperties(this.faqHeading, "rgba(19,19,31,1)", "nbs", "h3");
    let faqText = coreLib.getText(this.faqText);
    expect(faqText).to.equal(EndScreenPageContent.faqText);
    coreLib.validateCSSProperties(this.faqText, "rgba(66,66,76,1)", "nbs", "p");
    let faqLinkText = coreLib.getText(this.faqHyperlink);
    expect(faqLinkText).to.equal(EndScreenPageContent.faqLinkText);
    let faqLink = coreLib.getAttribute(this.faqHyperlink,"href");
    expect(faqLink).to.equal(EndScreenPageContent.faqLink);
  }

  contentValidationBeforeThreeMins() {
    let tableHeading = this.tableHeadingText.isDisplayed();
    expect(tableHeading).to.equal(true);
    let tableHeadingText = coreLib.getText(this.tableHeadingText);
    expect(tableHeadingText).to.equal(EndScreenPageContent.tableHeading);
    coreLib.validateCSSProperties(this.tableHeadingText, "rgba(19,19,31,1)", "nbs", "h2");
    let sortCode = this.sortCodeText.isDisplayed();
    expect(sortCode).to.equal(true);
    let sortCodeText = coreLib.getText(this.sortCodeText);
    expect(sortCodeText).to.equal(EndScreenPageContent.sortCodeText);
    let accountNumber = this.accountNumberText.isDisplayed();
    expect(accountNumber).to.equal(true);
    let accountNumberText = coreLib.getText(this.accountNumberText);
    expect(accountNumberText).to.equal(EndScreenPageContent.accountNumber);
    let arrangedOverdraft = this.arrangedOverdraftText.isDisplayed();
    expect(arrangedOverdraft).to.equal(true);
    let arrangedOverdraftText = coreLib.getText(this.arrangedOverdraftText);
    expect(arrangedOverdraftText).to.equal(EndScreenPageContent.arrangedOverdraft);
    let finalPageWarningText = coreLib.getText(this.finalPageWarningBeforeThreeMins);
    expect(finalPageWarningText).to.equal(EndScreenPageContent.finalPageWarningBeforeThreeMins);
    coreLib.validateCSSProperties(this.finalPageWarningBeforeThreeMins, "rgba(66,66,76,1)", "nbs", "p");
    let timerText = this.warningMessageText.isDisplayed();
    expect(timerText).to.equal(true);
    coreLib.validateCSSProperties(this.warningMessageText, "rgba(19,19,31,1)", "nbs", "h3");
  }

  contentValidationAfterThreeMins() {
    coreLib.waitUntilElementTextExist(this.finalPageWarningAfterThreeMins, "We’ve hidden your account details to keep them safe.", 181000);
    let tableHeading = this.tableHeadingText.isExisting();
    expect(tableHeading).to.equal(false);
    let finalPageWarningText = coreLib.getText(this.finalPageWarningAfterThreeMins);
    expect(finalPageWarningText).to.equal(EndScreenPageContent.finalPageWarningAfterThreeMins);
    coreLib.validateCSSProperties(this.finalPageWarningAfterThreeMins, "rgba(66,66,76,1)", "nbs", "p");
 }

  validateHyperlink(hyperlink) {
    browser.pause(3000);
    browser.switchWindow(hyperlink);
    return browser.pageLoaded();
 }

}

export default new EndScreenPage();