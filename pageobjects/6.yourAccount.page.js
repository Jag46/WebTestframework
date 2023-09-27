import BasePage from "./base.page";
import coreLib from "../utilities/coreLibrary";
import YourAccountContent from "../contents/yourAccountContent";
import genericPage from "../pageobjects/genericPage.page";
import checkYourDetailsPage from "../pageobjects/2.checkYourDetails.page.js";
import YourAccountChange from "../pageobjects/5.yourAccountChange.page";

class YourAccountPage extends BasePage {
  /**
   * Define Your Account Page Elements
   */

  isOpen() {
    browser.waitForUrl(
      "https://nbs-banking-webapp-ipc-int.dev4.edb-a.eu-west-2.notprod.thenbs.io/your-account",
      10000
    );
    return browser.pageLoaded();
  }

  get backButtonLinkContent() {
    return $("[data-ref='components.buttons.backBtn.linkContent']");
  }

  get continueButton(){
    return $("[data-ref='accountCompare.continueButton.button']");
  }

  get stepText() {
    return $("[data-ref='steps.text']");
  }

  get yourAccountHeading() {
    return $("[data-ref='yourAccountHeading.pageHeadingTitle.heading']");
  }

  get yourAccountSubHeading() {
    return $("[data-ref='yourAccountSubHeading.text']");
  }

  get yourCardHeading() {
    return $("[data-ref='yourCardHeading.heading']");
  }

  get yourCardSubHeading() {
    return $("[data-ref='yourCardSubHeading.text']");
  }

  get paperlessHeading() {
    return $("[data-ref='paperlessHeading.heading']");
  }

  get paperlessSubHeading() {
    return $("[data-ref='paperlessSubHeading_paperlessOnly.text']");
  }

  get yourCheckbookHeading() {
    return $("[data-ref='yourChequeBookHeading.heading']");
  }

  get yourCheckbookSubHeading() {
    return $("[data-ref='yourChequeBookSubHeading.text']");
  }

  get checkBoxTitle() {
    return $("[data-ref='checkBoxTitle.checkbox']");
  }

  get marketingPrefHeading() {
    return $("[data-ref='marketingPreferences.heading']");
  }

  get marketingPrefSubHeading() {
    return $("[data-ref='preferenceSubHeading.text']");
  }

  get marketingPrefFirstList() {
    return $("[data-ref='firstlistItem']");
  }

  get marketingPrefSecondList() {
    return $("[data-ref='secondlistItem']");
  }

  get marketingPrefThirdList() {
    return $("[data-ref='thirdlistItem']");
  }

  get marketingPrefFooter() {
    return $("[data-ref='preferenceFooter.text']");
  }

  get infoMessageHeader() {
    return $("[data-ref='info.messageHeader.text']");
  }

  get infoMessageContent() {
    return $("[data-ref='informationMessageContent.text']");
  }

  get heading3() {
    return $("[data-ref='heading']");
  }

  get marketingEmailLabel() {
    return $("[data-ref='marketingEmail.fieldLabel']");
  }

  get marketingLetterLabel() {
    return $("[data-ref='marketingLetter.fieldLabel']");
  }

  get marketingTepehoneLabel() {
    return $("[data-ref='marketingTelephone.fieldLabel']");
  }

  get marketingEmailRadioYes() {
    return $("[data-ref='marketingEmail.marketingEmail0.radio']");
  }

  get marketingEmailRadioNo() {
    return $("[data-ref='marketingEmail.marketingEmail1.radio']");
  }

  get marketingLetterRadioYes() {
    return $("[data-ref='marketingLetter.marketingLetter0.radio']");
  }

  get marketingLetterRadioNo() {
    return $("[data-ref='marketingLetter.marketingLetter1.radio']");
  }

  get marketingTelephoneRadioYes() {
    return $("[data-ref='marketingTelephone.marketingTelephone0.radio']");
  }

  get marketingTelephoneRadioNo() {
    return $("[data-ref='marketingTelephone.marketingTelephone1.radio']");
  }

  get marketingEmailRadioYesState() {
    return $("[data-ref='marketingEmail.marketingEmail0.radioInput']");
  }

  get marketingEmailRadioNoState() {
    return $("[data-ref='marketingEmail.marketingEmail1.radioInput']");
  }

  get marketingLetterRadioYesState() {
    return $("[data-ref='marketingLetter.marketingLetter0.radioInput']");
  }

  get marketingLetterRadioNoState() {
    return $("[data-ref='marketingLetter.marketingLetter1.radioInput']");
  }

  get chequeBookRequiredBoxState() {
    return $("[data-ref='checkBoxTitle.checkboxInput']");
  }

  get inlineLevelEmailsError() {
    return $("#marketingEmailAlerts");
  }

  get inlineLevelLettersError() {
    return $("#marketingLetterAlerts");
  }

  get inlineLevelCallsError() {
    return $("#marketingTelephoneAlerts");
  }

  get pageLevelMailError() {
    return $("[data-ref='marketingEmailError.linkContent']");
  }

  get pageLevelLettersError() {
    return $("[data-ref='marketingLetterError.linkContent']");
  }

  get pageLevelCallsError() {
    return $("[data-ref='marketingTelephoneError.linkContent']");
  }

  get errorHeader() {
    return $("[data-ref='formErrors.messageHeader.text']");
  }

  /******************
   * Action Methods
   ******************/
  clickBackButton() {
    coreLib.click(this.backButtonLinkContent);
  }

  clickContinueButton () {
    coreLib.focusAndClick(this.continueButton);
}

  selectCheckbookCheckBox() {
    coreLib.click(this.checkBoxTitle);
  }

  selectMarketingPrefEmailYes() {
    coreLib.click(this.marketingEmailRadioYes);
  }

  selectMarketingPrefEmailNo() {
    coreLib.click(this.marketingEmailRadioNo);
  }

  selectMarketingPrefLetterYes() {
    coreLib.click(this.marketingLetterRadioYes);
  }

  selectMarketingPrefLetterNo() {
    coreLib.click(this.marketingLetterRadioNo);
  }

  selectMarketingPrefTelehoneYes() {
    coreLib.click(this.marketingTelephoneRadioYes);
  }

  selectMarketingPrefTelehoneNo() {
    coreLib.click(this.marketingTelephoneRadioNo);
  }

  navigationToImportantInformationPage() {
    genericPage.clickContinueButton();
  }

  navigationToYourAccountPage(){
    checkYourDetailsPage.navigationToYourAccountChange();
    YourAccountChange.navigationToYourAccountPage();
  }

  /******************
   * Validation Methods
   ******************/
  contentValidation() {
    let backButtonLink = coreLib.getText(this.backButtonLinkContent);
    expect(backButtonLink).to.equal(YourAccountContent.backButtonLinkContent);
    let stepText = coreLib.getText(this.stepText);
    expect(stepText).to.equal(YourAccountContent.stepText);

    let accountHeading = coreLib.getText(this.yourAccountHeading);
    expect(accountHeading).to.equal(YourAccountContent.yourAccountHeading);
    let accountSubHeading = coreLib.getText(this.yourAccountSubHeading);
    expect(accountSubHeading).to.equal(
      YourAccountContent.yourAccountSubHeading
    );
    let cardHeading = coreLib.getText(this.yourCardHeading);
    expect(cardHeading).to.equal(YourAccountContent.yourCardHeading);
    let cardSubHeading = coreLib.getText(this.yourCardSubHeading);
    expect(cardSubHeading).to.equal(YourAccountContent.yourCardSubHeading);

    let paperlessHeading = coreLib.getText(this.paperlessHeading);
    expect(paperlessHeading).to.equal(YourAccountContent.paperlessHeading);
    let paperlessSubHeading = coreLib.getText(this.paperlessSubHeading);
    expect(paperlessSubHeading).to.equal(
      YourAccountContent.paperlessSubHeading
    );
    let checkbookHeading = coreLib.getText(this.yourCheckbookHeading);
    expect(checkbookHeading).to.equal(YourAccountContent.yourCheckbookHeading);
    let checkbookSubHeading = coreLib.getText(this.yourCheckbookSubHeading);
    expect(checkbookSubHeading).to.equal(
      YourAccountContent.yourCheckbookSubHeading
    );
    let checkbookText = coreLib.getText(this.checkBoxTitle);
    expect(checkbookText).to.equal(YourAccountContent.checkBoxText);

    let marketingHeading = coreLib.getText(this.marketingPrefHeading);
    expect(marketingHeading).to.equal(YourAccountContent.marketingPrefHeading);
    let marketingSubHeading = coreLib.getText(this.marketingPrefSubHeading);
    expect(marketingSubHeading).to.equal(
      YourAccountContent.marketingPrefSubHeading
    );
    let marketingListOne = coreLib.getText(this.marketingPrefFirstList);
    expect(marketingListOne).to.equal(
      YourAccountContent.marketingPrefFirstList
    );
    let marketingListTwo = coreLib.getText(this.marketingPrefSecondList);
    expect(marketingListTwo).to.equal(
      YourAccountContent.marketingPrefSecondList
    );
    let marketingListThree = coreLib.getText(this.marketingPrefThirdList);
    expect(marketingListThree).to.equal(
      YourAccountContent.marketingPrefThirdList
    );

    let footer = coreLib.getText(this.marketingPrefFooter);
    expect(footer).to.equal(YourAccountContent.marketingPrefFooter);

    let warning = coreLib.getText(this.infoMessageHeader);
    expect(warning).to.equal(YourAccountContent.information);
    let infoMessage = coreLib.getText(this.infoMessageContent);
    expect(infoMessage).to.equal(YourAccountContent.informationMessage);

    let heading3 = coreLib.getText(this.heading3);
    expect(heading3).to.equal(YourAccountContent.heading3);
    let email = coreLib.getText(this.marketingEmailLabel);
    expect(email).to.equal(YourAccountContent.emails);
    let letter = coreLib.getText(this.marketingLetterLabel);
    expect(letter).to.equal(YourAccountContent.letters);
    let call = coreLib.getText(this.marketingTepehoneLabel);
    expect(call).to.equal(YourAccountContent.calls);
  }

  verifyNoMarketingPrefSelectedError() {
    let inlineError1 = coreLib.getText(this.inlineLevelEmailsError);
    expect(inlineError1).to.equal(
      YourAccountContent.noEmailMarketingPrefSelectedError
    );
    let pageError1 = coreLib.getText(this.pageLevelMailError);
    expect(pageError1).to.equal(
      YourAccountContent.noEmailMarketingPrefSelectedError
    );
    let inlineError2 = coreLib.getText(this.inlineLevelLettersError);
    expect(inlineError2).to.equal(
      YourAccountContent.noLetterMarketingPrefSelectedError
    );
    let pageError2 = coreLib.getText(this.pageLevelLettersError);
    expect(pageError2).to.equal(
      YourAccountContent.noLetterMarketingPrefSelectedError
    );
    let inlineError3 = coreLib.getText(this.inlineLevelCallsError);
    expect(inlineError3).to.equal(
      YourAccountContent.noCallsMarketingPrefSelectedError
    );
    let pageError3 = coreLib.getText(this.pageLevelCallsError);
    expect(pageError3).to.equal(
      YourAccountContent.noCallsMarketingPrefSelectedError
    );
    let headerError = coreLib.getText(this.errorHeader);
    expect(headerError).to.equal(YourAccountContent.headerError3);
  }

  verifyTwoOfMarketingPrefSelectedError() {
    let inlineError1 = coreLib.getText(this.inlineLevelEmailsError);
    expect(inlineError1).to.equal(
      YourAccountContent.noEmailMarketingPrefSelectedError
    );
    let pageError1 = coreLib.getText(this.pageLevelMailError);
    expect(pageError1).to.equal(
      YourAccountContent.noEmailMarketingPrefSelectedError
    );
    let inlineError2 = coreLib.getText(this.inlineLevelLettersError);
    expect(inlineError2).to.equal(
      YourAccountContent.noLetterMarketingPrefSelectedError
    );
    let pageError2 = coreLib.getText(this.pageLevelLettersError);
    expect(pageError2).to.equal(
      YourAccountContent.noLetterMarketingPrefSelectedError
    );
    let headerError = coreLib.getText(this.errorHeader);
    expect(headerError).to.equal(YourAccountContent.headerError2);
  }

  verifyOnly1MarketingPrefSelectedError() {
    let inlineError1 = coreLib.getText(this.inlineLevelEmailsError);
    expect(inlineError1).to.equal(
      YourAccountContent.noEmailMarketingPrefSelectedError
    );
    let pageError1 = coreLib.getText(this.pageLevelMailError);
    expect(pageError1).to.equal(
      YourAccountContent.noEmailMarketingPrefSelectedError
    );
    let headerError = coreLib.getText(this.errorHeader);
    expect(headerError).to.equal(YourAccountContent.headerError1);
  }

  prepopulatedFieldsValidationForNo(){
    let checkButtonState = (this.chequeBookRequiredBoxState).getAttribute("checked");
    expect(coreLib.isSelected(this.chequeBookRequiredBoxState)).to.equal(false);
    expect(checkButtonState).to.equal('false');
    let emailRadioButton = (this.marketingEmailRadioYesState).getAttribute("checked");
    expect(coreLib.isSelected(this.marketingEmailRadioYesState)).to.equal(true);
    expect(emailRadioButton).to.equal('true');
    let letterRadioButton = (this.marketingLetterRadioYesState).getAttribute("checked");
    expect(coreLib.isSelected(this.marketingLetterRadioYesState)).to.equal(true);
    expect(letterRadioButton).to.equal('true');
  }

  prepopulatedFieldsValidationForYes(){
    let checkButtonState = (this.chequeBookRequiredBoxState).getAttribute("checked");
    expect(coreLib.isSelected(this.chequeBookRequiredBoxState)).to.equal(true);
    expect(checkButtonState).to.equal('true');
    let emailRadioButton = (this.marketingEmailRadioNoState).getAttribute("checked");
    expect(coreLib.isSelected(this.marketingEmailRadioNoState)).to.equal(true);
    expect(emailRadioButton).to.equal('true');
    let letterRadioButton = (this.marketingLetterRadioNoState).getAttribute("checked");
    expect(coreLib.isSelected(this.marketingLetterRadioNoState)).to.equal(true);
    expect(letterRadioButton).to.equal('true');
  }
}

export default new YourAccountPage();
