import BasePage from "./base.page";
import coreLib from "../utilities/coreLibrary";
import importantInformationContent from "../contents/importantInformationContent";
import { expect } from "chai";
import genericPage from "../pageobjects/genericPage.page";

class ImportantInformationPage extends BasePage {
  /**
   * Define Important Information Page Elements
   */

  get pageHeading() {
    return $("[data-ref='ImportantInformationPageHeading.pageHeadingTitle.heading']");
  }

  get backButtonLink(){
    return $("[data-ref='components.buttons.backBtn.linkContent']");
  }

  get stepText(){
    return $("[data-ref='steps.text']");
  }

  get ImportantInformationParagraph1Text(){
    return $("[data-ref='ImportantInformationPageParagraph1.text']");
  }

  get ImportantInformationParagraph2Text(){
    return $("[data-ref='ImportantInformationPageParagraph2.text']");
  }

  get ImportantInformationParagraph3Text(){
    return $("[data-ref='ImportantInformationPageParagraph3.text']");
  }

  get ImportantInformationParagraph4Text(){
    return $("[data-ref='ImportantInformationPageParagraph4.text']");
  }

  get ImportantInformationPageHeading2(){
    return $("[data-ref='ImportantInformationPageHeading2.heading']");
  }

  get arrangedOverdraftAgreementLink(){
    return $("[data-ref='ImportantInformationPageLink1.linkContent']");
  }

  get overdraftAgreementModalCloseButton(){
    return $("[data-ref='ArrangedOverdraftModal.modalClose.button']");
  }

  get overdraftAgreementModalTopCloseButton(){
    return $("[data-ref='ArrangedOverdraftModal.modalClose.button']");
  }

  get arrangedOverdraftAgreementHeaderText(){
    return $("[data-ref='ArrangedOverdraftModal.modal.heading']");
  }

  get arrangedOverdraftBottomCloseButton(){
    return $("[data-ref='ArrangedOverdraftModalCloseButton.button']");
  }

  get arrangedOverdraftAgreementText(){
    return $("body > div:nth-child(2) > div:nth-child(1) > div:nth-child(3) > div:nth-child(1) > div:nth-child(1) > div:nth-child(2) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > p:nth-child(10)");
  }

  get ratesAndChargesLink(){
    return $("[data-ref='ImportantInformationPageLink2.linkContent']");
  }

  get feeInformationDocumentLink(){
    return $("[data-ref='ImportantInformationPageLink3.linkContent']");
  }

  get FSCSDocumentLink(){
    return $("[data-ref='ImportantInformationPageLink4.linkContent']");
  }

  get charitableAssignmentLink(){
    return $("[data-ref='ImportantInformationPageLink5.linkContent']");
  }

  get nationwideRulesLink(){
    return $("[data-ref='ImportantInformationPageLink6.linkContent']");
  }

  get pageWarningTextHeader(){
    return $("[data-ref='ImportantInformationPageWarning.messageHeader.text']");
  }

  get pageWarningText(){
    return $("[data-ref='ImportantInformationPageWarning.message']");
  }

  get tncAgreeButton(){
    return $("[data-ref='agree.button']");
  }

  get tncDisagreeButton(){
    return $("[data-ref='disagree.button']");
  }

  get tncModalHeading(){
    return $("[data-ref='modal.heading']");
  }

  get tncModalCloseButton(){
    return $("[data-ref='modalClose.button']");
  }

  get pcciModalCloseButton(){
    return $("[data-ref='modalClose.button']");
  }

  get tncHeaderErrorText(){
    return $("[data-ref='termsAndConditionsError.linkContent']");
  }

  get tncAlertText(){
    return $("[data-ref='termsAndConditions.fieldAlerts.fieldAlerts.messageContent']");
  }

  get tncAcceptGreenTick() {
    return $("[data-ref='button.icon']");
  }

  get tncAccetButton(){
    return $("button[id='termsAndConditions'] span[class='nel-Button-buttonContent-0-3-517']");
  }


  get pcciModalHeading(){
    return $("[data-ref='modal.heading']");
  }

  get pcciAgreeButton(){
    return $("[data-ref='accept.button']");
  }

  get pcciAcceptGreenTick() {
    return $("[data-ref='button.icon']");
  }

  get pcciAccetButton(){
    return $("button[id='pcci'] span[class='nel-Button-buttonContent-0-3-517']");
  }

  get pcciHeaderErrorText(){
    return $("[data-ref='pcciError.linkContent']");
  }

  get pcciAlertText(){
    return $("[data-ref='pcci.fieldAlerts.fieldAlerts.messageContent']");
  }

  get tncButton(){
    return $("//button[@id='termsAndConditions']");
  }

  get tncAgreementText(){
    return $("//div[@id='current-document']/section[@class='tnc-content']/p[37]");
  }

  get pcciButton(){
    return $("//button[@id='pcci']");
  }

  /******************
   * Action Methods
   ******************/
  
   isOpen() {
    browser.waitForUrl(
      "https://nbs-banking-webapp-ipc-int.dev4.edb-a.eu-west-2.notprod.thenbs.io/important-information",
      10000
    );
    return browser.pageLoaded();
  }

  validateHyperlink(hyperlink) {
    browser.pause(3000);
    browser.switchWindow(hyperlink);
    return browser.pageLoaded();
  }

  switchBackToImportantInformationWindow(){
      browser.switchWindow(
        "https://nbs-banking-webapp-ipc-int.dev4.edb-a.eu-west-2.notprod.thenbs.io/important-information"
      );
  }

  clickBackButton() {
    coreLib.click(this.backButtonLink);
  }

  tncAcceptance() {
    coreLib.click(this.tncAgreeButton);
  }

  pcciAcceptance() {
    coreLib.click(this.pcciAgreeButton);
  }
  
  clickTnCButton() {
    coreLib.click(this.tncButton);
  }

  clickPcciButton() {
    coreLib.click(this.pcciButton);
  }

  agreeTermsAndConditionsModal() {
    this.clickTnCButton();
    let tncHeadingText = coreLib.getText(this.tncModalHeading);
    expect(tncHeadingText).to.equal(importantInformationContent.tncModalHeadingText);
    this.tncAcceptance();
  }

  agreePCCIModal() {
    this.clickPcciButton();
    let pcciHeadingText = coreLib.getText(this.pcciModalHeading);
    expect(pcciHeadingText).to.equal(importantInformationContent.pcciModalHeadingText);
    this.pcciAcceptance();
  }

  disagreeTermsAndConditionsModal() {
    this.clickTnCButton();
    this.tncModalHeading.waitForDisplayed();
    coreLib.click(this.tncDisagreeButton);
  }

  closePCCIModal() {
    this.clickPcciButton();
    this.pcciModalHeading.waitForDisplayed();
    coreLib.click(this.pcciModalCloseButton);
  }

  arrangedOverdraftAgreementModalButtonsActions(){
    coreLib.click(this.arrangedOverdraftAgreementLink);
    this.arrangedOverdraftAgreementHeaderText.waitForDisplayed();
    coreLib.click(this.arrangedOverdraftBottomCloseButton);
    coreLib.click(this.arrangedOverdraftAgreementLink);
    this.arrangedOverdraftAgreementHeaderText.waitForDisplayed();
    coreLib.click(this.overdraftAgreementModalTopCloseButton);
  }

  tncModalButtonsActions(){
    coreLib.click(this.tncButton);
    this.tncModalHeading.waitForDisplayed();
    coreLib.click(this.tncModalCloseButton);
    let alertText = coreLib.getText(this.tncAlertText);
    expect(alertText).to.equal(importantInformationContent.tncAlertText);
    coreLib.click(this.tncButton);
    this.tncModalHeading.waitForDisplayed();
    coreLib.click(this.tncDisagreeButton);
    expect(alertText).to.equal(importantInformationContent.tncAlertText);
    coreLib.click(this.tncButton);
    this.tncModalHeading.waitForDisplayed();
    coreLib.click(this.tncAgreeButton);
    expect(this.tncAcceptGreenTick.isExisting()).to.equal(true);
   // expect(this.tncAccetButton.isExisting()).to.equal(true);
  }

  pcciModalButtonsActions(){
    coreLib.click(this.pcciButton);
    this.pcciModalHeading.waitForDisplayed();
    coreLib.click(this.pcciModalCloseButton);
    let alertText = coreLib.getText(this.pcciAlertText);
    expect(alertText).to.equal(importantInformationContent.pcciAlertText);
    coreLib.click(this.pcciButton);
    this.pcciModalHeading.waitForDisplayed();
    this.pcciAcceptance();
    expect(this.pcciAcceptGreenTick.isExisting()).to.equal(true);
    //expect(this.pcciAccetButton.isExisting()).to.equal(true);
  }

  navigationToCompleteAccountChangePage(){
    this.agreeTermsAndConditionsModal();
    this.agreePCCIModal();
    genericPage.clickContinueButton();
  }

  /******************
  * Validation Methods
  ******************/

  pageContentValidation() {
    let headerText = coreLib.getText(this.pageHeading);
    expect(headerText).to.equal(importantInformationContent.pageHeader);
    coreLib.validateCSSProperties(this.pageHeading, "rgba(19,19,31,1)", "cabernetjfpro", "h1");
    let headerText2 = coreLib.getText(this.ImportantInformationPageHeading2);
    expect(headerText2).to.equal(importantInformationContent.pageHeading2);
    coreLib.validateCSSProperties(this.ImportantInformationPageHeading2, "rgba(19,19,31,1)", "nbs", "h3");
    let backButton = coreLib.getText(this.backButtonLink);
    expect(backButton).to.equal(importantInformationContent.backButton);
    coreLib.validateCSSProperties(this.backButtonLink, "rgba(0,41,121,1)", "nbs", "span");
    // let stepText = coreLib.getText(this.stepText);
    // expect(stepText).to.equal(importantInformationContent.stepNumber);
    let PageParagraph1 = coreLib.getText(this.ImportantInformationParagraph1Text);
    expect(PageParagraph1).to.equal(importantInformationContent.pageParagraph1Text);
    coreLib.validateCSSProperties(this.ImportantInformationParagraph1Text, "rgba(66,66,76,1)", "nbs", "p");
    let PageParagraph2 = coreLib.getText(this.ImportantInformationParagraph2Text);
    expect(PageParagraph2).to.equal(importantInformationContent.pageParagraph2Text);
    coreLib.validateCSSProperties(this.ImportantInformationParagraph2Text, "rgba(66,66,76,1)", "nbs", "p");
    let PageParagraph3 = coreLib.getText(this.ImportantInformationParagraph3Text);
    expect(PageParagraph3).to.equal(importantInformationContent.pageParagraph3Text);
    coreLib.validateCSSProperties(this.ImportantInformationParagraph3Text, "rgba(66,66,76,1)", "nbs", "p");
    let PageParagraph4 = coreLib.getText(this.ImportantInformationParagraph4Text);
    expect(PageParagraph4).to.equal(importantInformationContent.pageParagraph4Text);
    coreLib.validateCSSProperties(this.ImportantInformationParagraph4Text, "rgba(66,66,76,1)", "nbs", "p");
    let warningText = coreLib.getText(this.pageWarningText);
    expect(warningText).to.equal(importantInformationContent.pageWarningMessage);
    coreLib.validateCSSProperties(this.pageWarningText, "rgba(66,66,76,1)", "nbs", "div");
    coreLib.validateCSSProperties(this.pageWarningTextHeader, "rgba(19,19,31,1)", "nbs", "h2");
  }

  pageContentValidationWithoutOD() {
    let headerText = coreLib.getText(this.pageHeading);
    expect(headerText).to.equal(importantInformationContent.pageHeader);
    coreLib.validateCSSProperties(this.pageHeading, "rgba(19,19,31,1)", "cabernetjfpro", "h1");
    let headerText2 = coreLib.getText(this.ImportantInformationPageHeading2);
    expect(headerText2).to.equal(importantInformationContent.pageHeading2);
    coreLib.validateCSSProperties(this.ImportantInformationPageHeading2, "rgba(19,19,31,1)", "nbs", "h3");
    let backButton = coreLib.getText(this.backButtonLink);
    expect(backButton).to.equal(importantInformationContent.backButton);
    coreLib.validateCSSProperties(this.backButtonLink, "rgba(0,41,121,1)", "nbs", "span");
    // let stepText = coreLib.getText(this.stepText);
    // expect(stepText).to.equal(importantInformationContent.stepNumber);
    let PageParagraph1 = coreLib.getText(this.ImportantInformationParagraph1Text);
    expect(PageParagraph1).to.equal(importantInformationContent.pageParagraph1Text);
    coreLib.validateCSSProperties(this.ImportantInformationParagraph1Text, "rgba(66,66,76,1)", "nbs", "p");
    let PageParagraph2 = coreLib.getText(this.ImportantInformationParagraph2Text);
    expect(PageParagraph2).to.equal(importantInformationContent.pageParagraph2Text);
    coreLib.validateCSSProperties(this.ImportantInformationParagraph2Text, "rgba(66,66,76,1)", "nbs", "p");
    let PageParagraph3 = coreLib.getText(this.ImportantInformationParagraph3Text);
    expect(PageParagraph3).to.equal(importantInformationContent.pageParagraph3Text);
    coreLib.validateCSSProperties(this.ImportantInformationParagraph3Text, "rgba(66,66,76,1)", "nbs", "p");
    let PageParagraph4 = coreLib.getText(this.ImportantInformationParagraph4Text);
    expect(PageParagraph4).to.equal(importantInformationContent.pageParagraph4TextWithoutOD);
    coreLib.validateCSSProperties(this.ImportantInformationParagraph4Text, "rgba(66,66,76,1)", "nbs", "p");
    let warningText = coreLib.getText(this.pageWarningText);
    expect(warningText).to.equal(importantInformationContent.pageWarningMessage);
    coreLib.validateCSSProperties(this.pageWarningText, "rgba(66,66,76,1)", "nbs", "div");
    coreLib.validateCSSProperties(this.pageWarningTextHeader, "rgba(19,19,31,1)", "nbs", "h2");
  }

  pageLinksContentValidation(){
    let pageLink1text = coreLib.getText(this.arrangedOverdraftAgreementLink);
    expect(pageLink1text).to.equal(importantInformationContent.pageLink1Text);
    coreLib.validateCSSProperties(this.arrangedOverdraftAgreementLink, "rgba(0,41,121,1)", "nbs", "span");
    let pageLink2text = coreLib.getText(this.ratesAndChargesLink);
    expect(pageLink2text).to.equal(importantInformationContent.pageLink2Text);
    coreLib.validateCSSProperties(this.ratesAndChargesLink, "rgba(0,41,121,1)", "nbs", "span");
    let pageLink3text = coreLib.getText(this.feeInformationDocumentLink);
    expect(pageLink3text).to.equal(importantInformationContent.pageLink3Text);
    coreLib.validateCSSProperties(this.feeInformationDocumentLink, "rgba(0,41,121,1)", "nbs", "span");
    let pageLink4text = coreLib.getText(this.FSCSDocumentLink);
    expect(pageLink4text).to.equal(importantInformationContent.pageLink4Text);
    coreLib.validateCSSProperties(this.FSCSDocumentLink, "rgba(0,41,121,1)", "nbs", "span");
    let pageLink5text = coreLib.getText(this.charitableAssignmentLink);
    expect(pageLink5text).to.equal(importantInformationContent.pageLink5Text);
    coreLib.validateCSSProperties(this.charitableAssignmentLink, "rgba(0,41,121,1)", "nbs", "span");
    let pageLink6text = coreLib.getText(this.nationwideRulesLink);
    expect(pageLink6text).to.equal(importantInformationContent.pageLink6Text);
    coreLib.validateCSSProperties(this.nationwideRulesLink, "rgba(0,41,121,1)", "nbs", "span");
  }

  pageLinksContentValidationWithoutOD(){
    let pageLink2text = coreLib.getText(this.ratesAndChargesLink);
    expect(pageLink2text).to.equal(importantInformationContent.pageLink2Text);
    coreLib.validateCSSProperties(this.ratesAndChargesLink, "rgba(0,41,121,1)", "nbs", "span");
    let pageLink3text = coreLib.getText(this.feeInformationDocumentLink);
    expect(pageLink3text).to.equal(importantInformationContent.pageLink3Text);
    coreLib.validateCSSProperties(this.feeInformationDocumentLink, "rgba(0,41,121,1)", "nbs", "span");
    let pageLink4text = coreLib.getText(this.FSCSDocumentLink);
    expect(pageLink4text).to.equal(importantInformationContent.pageLink4Text);
    coreLib.validateCSSProperties(this.FSCSDocumentLink, "rgba(0,41,121,1)", "nbs", "span");
    let pageLink5text = coreLib.getText(this.charitableAssignmentLink);
    expect(pageLink5text).to.equal(importantInformationContent.pageLink5Text);
    coreLib.validateCSSProperties(this.charitableAssignmentLink, "rgba(0,41,121,1)", "nbs", "span");
    let pageLink6text = coreLib.getText(this.nationwideRulesLink);
    expect(pageLink6text).to.equal(importantInformationContent.pageLink6Text);
    coreLib.validateCSSProperties(this.nationwideRulesLink, "rgba(0,41,121,1)", "nbs", "span");
  }

  validateArrangedOverdraftAgreementModal(){
    coreLib.click(this.arrangedOverdraftAgreementLink);
    let arrangedOverdraftAgreementHeaderText = coreLib.getText(this.arrangedOverdraftAgreementHeaderText);
    expect(arrangedOverdraftAgreementHeaderText).to.equal(importantInformationContent.overdraftModalHeader);
    this.arrangedOverdraftAgreementText.scrollIntoView();
    let overdraftModalAgreementText = coreLib.getText(this.arrangedOverdraftAgreementText);
    expect(overdraftModalAgreementText).to.equal(importantInformationContent.overdraftAgreementWords);
    coreLib.click(this.arrangedOverdraftBottomCloseButton);
  }

  errorLinkMessagesValidation(){
    let errorLinkText1 = coreLib.getText(this.pcciHeaderErrorText);
    expect(errorLinkText1).to.equal(importantInformationContent.pcciHeaderLinkErrorText);
    coreLib.validateCSSProperties(this.pcciHeaderErrorText, "rgba(0,41,121,1)", "nbs", "span");
    let errorLinkText2 = coreLib.getText(this.tncHeaderErrorText);
    expect(errorLinkText2).to.equal(importantInformationContent.tncHeaderLinkErrorText);
    coreLib.validateCSSProperties(this.tncHeaderErrorText, "rgba(0,41,121,1)", "nbs", "span");
  }

  errorAlertMessagesValidation(){
    let alertText1 = coreLib.getText(this.pcciAlertText);
    expect(alertText1).to.equal(importantInformationContent.pcciAlertText);
    coreLib.validateCSSProperties(this.pcciAlertText, "rgba(66,66,76,1)", "nbs", "div");
    let alertText2 = coreLib.getText(this.tncAlertText);
    expect(alertText2).to.equal(importantInformationContent.tncAlertText);
    coreLib.validateCSSProperties(this.tncAlertText, "rgba(66,66,76,1)", "nbs", "div");
  }

  modalbuttonContentValidation(){
    //Validating Arranged Overdraft Agreement
    let arrangedOverdraftAgreementLinkText = coreLib.getText(this.arrangedOverdraftAgreementLink);
    expect(arrangedOverdraftAgreementLinkText).to.equal(importantInformationContent.pageLink1Text);
    coreLib.validateCSSProperties(this.arrangedOverdraftAgreementLink, "rgba(0,41,121,1)", "nbs", "span");
    this.validateArrangedOverdraftAgreementModal();

    //Validating PCCI modal content
    let pcciButtonText = coreLib.getText(this.pcciButton);
    expect(pcciButtonText).to.equal(importantInformationContent.button1Text);
    coreLib.validateCSSProperties(this.pcciButton, "rgba(0,41,121,1)", "nbs", "button");
    this.agreePCCIModal();

    //Validating TnC modal content
    let tncButtonText = coreLib.getText(this.tncButton);
    expect(tncButtonText).to.equal(importantInformationContent.button2Text);
    coreLib.validateCSSProperties(this.tncButton, "rgba(0,41,121,1)", "nbs", "button");
    this.clickTnCButton();
    let tncHeadingText = coreLib.getText(this.tncModalHeading);
    expect(tncHeadingText).to.equal(importantInformationContent.tncModalHeadingText);
    this.tncAgreementText.scrollIntoView();
    let tncAgreementText = coreLib.getText(this.tncAgreementText);
    expect(tncAgreementText).to.equal(importantInformationContent.tncModalAgreementWords);
    this.tncAcceptance();
  }

  modalbuttonContentValidationWithoutOD(){
    //Validating TnC modal content
    let tncButtonText = coreLib.getText(this.tncButton);
    expect(tncButtonText).to.equal(importantInformationContent.button2Text);
    coreLib.validateCSSProperties(this.tncButton, "rgba(0,41,121,1)", "nbs", "button");
    this.clickTnCButton();
    let tncHeadingText = coreLib.getText(this.tncModalHeading);
    expect(tncHeadingText).to.equal(importantInformationContent.tncModalHeadingText);
    this.tncAgreementText.scrollIntoView();
    let tncAgreementText = coreLib.getText(this.tncAgreementText);
    expect(tncAgreementText).to.equal(importantInformationContent.tncModalAgreementWords);
    this.tncAcceptance();
  }
}

export default new ImportantInformationPage();