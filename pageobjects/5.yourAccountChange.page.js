import BasePage from "./base.page";
import coreLib from "../utilities/coreLibrary";
import YourAccountChangeContent from "../contents/yourAccountChangeContent";
import genericPage from "../pageobjects/genericPage.page";

class YourAccountChangePage extends BasePage {
  /**
   * Define Your Account Change Page Elements
   */

  isOpen() {
    browser.waitForUrl(
      "https://nbs-banking-webapp-ipc-int.dev4.edb-a.eu-west-2.notprod.thenbs.io/account-compare",
      20000
    );
    return browser.pageLoaded();
  }

  get backButtonLinkContent() {
    return $("[data-ref='components.buttons.backBtn.linkContent']");
  }

  get stepText() {
    return $("[data-ref='steps.text']");
  }

  get accountCompareHeading() {
    return $("[data-ref='accountCompareHeading.pageHeadingTitle.heading']");
  }

  get accountCompareSubHeading() {
    return $("[data-ref='accountCompareSubHeading.text']");
  }

  get informationPanelHeading() {
    return $("[data-ref='informationPanelHeading.message']");
  }

  get existingAccountHeading() {
    return $(
      "[data-ref='cardHeader_Your existing FlexAccount details.heading']"
    );
  }

  get existingAccountFirstTitle() {
    return $("[data-ref='existingAccount-first-title.text']");
  }

  get existingAccountSecondTitle() {
    return $("[data-ref='existingAccount-second-title.text']");
  }

  get existingAccountSecondValueText() {
    return $("[data-ref='existingAccount-second-value.text']");
  }

  get existingAccountThirdTitle() {
    return $("[data-ref='existingAccount-third-title.text']");
  }

  get existingAccountMessage() {
    return $("[data-ref='existingAccount-top-message.messageContent']");
  }

  get newAccountHeading() {
    return $("[data-ref='cardHeader_Your FlexDirect details.heading']");
  }

  get newAccountFirstTitle() {
    return $("[data-ref='newAccount-first-title.text']");
  }

  get newAccountSecondTitle() {
    return $("[data-ref='newAccount-second-title.text']");
  }

  get newAccountSecondValueText() {
    return $("[data-ref='newAccount-second-value.text']");
  }

  get newAccountThirdTitle() {
    return $("[data-ref='newAccount-third-title.text']");
  }

  get accountBenefitsMessage() {
    return $("[data-ref='newAccount-paragraph-third-value.text']");
  }

  get importantMessage(){
    return $("[data-ref='newAccount-bottom-message.messageContent']");
  }

  get accountCompareFooterText() {
    return $("[data-ref='accountcompare.footer.text']");
  }

  /******************
   * Action Methods
   ******************/
  clickBackButton(){
    coreLib.click(this.backButtonLinkContent);
  }

  navigationToYourAccountPage() {
    genericPage.clickContinueButton();
  }


  /******************
   * Validation Methods
   ******************/
  contentValidation() {
    let backButtonLink = coreLib.getText(this.backButtonLinkContent);
    expect(backButtonLink).to.equal(
      YourAccountChangeContent.backButtonLinkContent
    );
    let stepText = coreLib.getText(this.stepText);
    expect(stepText).to.equal(
      YourAccountChangeContent.stepText
    );
    let heading = coreLib.getText(this.accountCompareHeading);
    expect(heading).to.equal(
      YourAccountChangeContent.accountCompareHeading
    );
    let subHeading = coreLib.getText(this.accountCompareSubHeading);
    expect(subHeading).to.equal(
      YourAccountChangeContent.accountCompareSubHeading
    );
    let existingAccountHeading = coreLib.getText(this.existingAccountHeading);
    expect(existingAccountHeading).to.equal(
      YourAccountChangeContent.existingAccountHeading
    );
    let existingAccountFirstTitle = coreLib.getText(this.existingAccountFirstTitle);
    expect(existingAccountFirstTitle).to.equal(
      YourAccountChangeContent.firstTitle
    );
    let existingAccountSecondTitle = coreLib.getText(this.existingAccountSecondTitle);
    expect(existingAccountSecondTitle).to.equal(
      YourAccountChangeContent.secondTitle
    );
    let existingAccountThirdTitle = coreLib.getText(this.existingAccountThirdTitle);
    expect(existingAccountThirdTitle).to.equal(
      YourAccountChangeContent.thirdTitle
    );
    let existingAccountSecondValueText = coreLib.getText(this.existingAccountSecondValueText);
    expect(existingAccountSecondValueText).to.equal(
      YourAccountChangeContent.existingAccountSecondValue
    );
    let existingAccountMessage = coreLib.getText(this.existingAccountMessage);
    expect(existingAccountMessage).to.equal(
      YourAccountChangeContent.existingAccountMessage
    );
    let newAccountHeading = coreLib.getText(this.newAccountHeading);
    expect(newAccountHeading).to.equal(
      YourAccountChangeContent.newAccountHeading
    );
    let newAccountFirstTitle = coreLib.getText(this.newAccountFirstTitle);
    expect(newAccountFirstTitle).to.equal(
      YourAccountChangeContent.firstTitle
    );
    let newAccountSecondTitle = coreLib.getText(this.newAccountSecondTitle);
    expect(newAccountSecondTitle).to.equal(
      YourAccountChangeContent.secondTitle
    );
    let newAccountThirdTitle = coreLib.getText(this.newAccountThirdTitle);
    expect(newAccountThirdTitle).to.equal(
      YourAccountChangeContent.thirdTitle
    );
    let newAccountSecondValueText = coreLib.getText(this.newAccountSecondValueText);
    expect(newAccountSecondValueText).to.equal(
      YourAccountChangeContent.newAccountSecondValue
    );
    let accountBenefitsImportantMessage = coreLib.getText(this.importantMessage);
    expect(accountBenefitsImportantMessage).to.equal(
      YourAccountChangeContent.importantMessage
    );
    let accountCompareFooterText = coreLib.getText(this.accountCompareFooterText);
    expect(accountCompareFooterText).to.equal(
      YourAccountChangeContent.accountCompareFooterText
    );
  }
}

export default new YourAccountChangePage();
