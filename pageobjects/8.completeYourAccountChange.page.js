import coreLib from "../utilities/coreLibrary";
import genericPage from "../pageobjects/genericPage.page";
import CompleteYourAccountChangeContent from "../contents/completeYourAccountChangeContent.js";
import checkYourDetailsPage from "../pageobjects/2.checkYourDetails.page.js";
import YourTaxPage from "../pageobjects/4.yourTax.page";
import YourAccountChange from "../pageobjects/5.yourAccountChange.page";
import YourAccount from "../pageobjects/6.yourAccount.page";
import importantInformationPage from "../pageobjects/7.importantInformation.page.js";
import { expect } from "chai";


class CompleteYourAccountChangePage {
  /**
   * Define Complete Your Account Change Page Elements
   */

  isOpen() {
    browser.waitForUrl(
      "https://nbs-banking-webapp-ipc-int.dev4.edb-a.eu-west-2.notprod.thenbs.io/complete-application",
      10000
    );
    return browser.pageLoaded();
  }

  get backButtonLinkContent() {
    return $("[data-ref='components.buttons.backBtn.linkContent']");
  }

  get stepText() {
    return $("[data-ref='steps.text']");
  }

  get completeApplicationHeading() {
    return $("[data-ref='pageHeading.pageHeadingTitle.heading']");
  }

  get completeApplicationSubHeading() {
    return $("[data-ref='pageSubHeading.text']");
  }

  get completeApplicationInfo() {
    return $("[data-ref='contentInfoHeading.text']");
  }

  get completeAccountChangeButton() {
    return $("[data-ref='continueButton.button']");
  }

  /******************
   * Action Methods
   ******************/
  clickBackButton() {
    coreLib.click(this.backButtonLinkContent);
  }

  clickCompleteAccountChangeButton () {
    coreLib.click(this.completeAccountChangeButton);
  }

  navigationToCompleteAccountChangePageViaTaxPage() {
    expect(checkYourDetailsPage.isOpen()).to.equal(true);
    let checkYourDetailsPageStepText = coreLib.getText(this.stepText);
    expect("Step 1 of 6").to.equal(checkYourDetailsPageStepText);
    checkYourDetailsPage.navigationToYourTaxPage();
    expect(YourTaxPage.isOpen()).to.equal(true);
    let yourTaxPageStepText = coreLib.getText(this.stepText);
    expect("Step 2 of 6").to.equal(yourTaxPageStepText);
    YourTaxPage.navigationToYourAccountChangePage();
    expect(YourAccountChange.isOpen()).to.equal(true);
    let yourAccountChangeStepText = coreLib.getText(this.stepText);
    expect("Step 3 of 6").to.equal(yourAccountChangeStepText);
    YourAccountChange.navigationToYourAccountPage();
    expect(YourAccount.isOpen()).to.equal(true);
    let YourAccountPageStepText = coreLib.getText(this.stepText);
    expect("Step 4 of 6").to.equal(YourAccountPageStepText);
    YourAccount.navigationToImportantInformationPage();
    expect(importantInformationPage.isOpen()).to.equal(true);
    let importantInformationPageStepText = coreLib.getText(this.stepText);
    expect("Step 5 of 6").to.equal(importantInformationPageStepText);
    importantInformationPage.navigationToCompleteAccountChangePage();
    expect(this.isOpen()).to.equal(true);
    let completeYourAccountChangePageStepText = coreLib.getText(this.stepText);
    expect("Step 6 of 6").to.equal(completeYourAccountChangePageStepText);
  }

  navigationToCompleteAccountChangePage() {
    expect(checkYourDetailsPage.isOpen()).to.equal(true);
    let checkYourDetailsPageStepText = coreLib.getText(this.stepText);
    expect("Step 1 of 5").to.equal(checkYourDetailsPageStepText);
    checkYourDetailsPage.navigationToYourAccountChange();
    expect(YourAccountChange.isOpen()).to.equal(true);
    let yourAccountChangeStepText = coreLib.getText(this.stepText);
    expect("Step 2 of 5").to.equal(yourAccountChangeStepText);
    YourAccountChange.navigationToYourAccountPage();
    expect(YourAccount.isOpen()).to.equal(true);
    let YourAccountPageStepText = coreLib.getText(this.stepText);
    expect("Step 3 of 5").to.equal(YourAccountPageStepText);
    YourAccount.navigationToImportantInformationPage();
    expect(importantInformationPage.isOpen()).to.equal(true);
    let importantInformationPageStepText = coreLib.getText(this.stepText);
    expect("Step 4 of 5").to.equal(importantInformationPageStepText);
    importantInformationPage.navigationToCompleteAccountChangePage();
    expect(this.isOpen()).to.equal(true);
    let completeYourAccountChangePageStepText = coreLib.getText(this.stepText);
    expect("Step 5 of 5").to.equal(completeYourAccountChangePageStepText);
}

  /******************
   * Validation Methods
   ******************/
  contentValidation() {
    let stepText = coreLib.getText(this.stepText);
    expect(stepText).to.equal(CompleteYourAccountChangeContent.stepText);
    let heading = coreLib.getText(this.completeApplicationHeading);
    expect(heading).to.equal(
      CompleteYourAccountChangeContent.completeApplicationHeading
    );
    coreLib.validateCSSProperties(this.completeApplicationHeading, "rgba(19,19,31,1)", "cabernetjfpro", "h1");
    let subHeading = coreLib.getText(this.completeApplicationSubHeading);
    expect(subHeading).to.equal(
      CompleteYourAccountChangeContent.completeApplicationSubHeading
    );
    let info = coreLib.getText(this.completeApplicationInfo);
    expect(info).to.equal(
      CompleteYourAccountChangeContent.informationPanelHeading
    );
    let buttonText = coreLib.getText(this.completeAccountChangeButton);
    expect(buttonText).to.equal(CompleteYourAccountChangeContent.buttonText);
  }
}

export default new CompleteYourAccountChangePage();