import BasePage from "./base.page";
import coreLib from "../utilities/coreLibrary";
import environment from "../support/env";
import technicalErrorContent from "../contents/ipcErrorPagesContents.js";
import { expect } from "chai";

class TechnicalErrorPage extends BasePage {
  /**
   * Define Generic Error Screen Elements
   */
  get heading() {
    return $("//h1");
  }

  get text1() {
    return $("[class*='Typography-lead']");
  }

  get text2() {
    return $("[class*='Typography-paragraph']");
  }

  /**
   * Define ID Status Error Screen Elements
   */

  get ErrorHeading() {
    return $("[data-ref='ErrorPageHeader.heading']");
  }

  get ErrorText() {
    return $("[data-ref='ErrorPageParagraph.text']");
  }

  get ErrorLink() {
    return $("[data-ref='ErrorPageLink.link']");
  }

  /**
   * Define Generic Error Screen Methods
   */

  isErrorPageOpen() {
    browser.waitForUrl(
      "https://nbs-banking-webapp-ipc-int.dev4.edb-a.eu-west-2.notprod.thenbs.io/error",
      20000
    );
    return browser.pageLoaded();
  }

  getErrorHeading() {
    return coreLib.getText(this.heading);
  }

  getErrorText1() {
    return coreLib.getText(this.text1);
  }

  getErrorText2() {
    return coreLib.getText(this.text2);
  }

  validateFieldsTechnicalErrorPage() {
    expect(this.getErrorHeading()).to.equal(technicalErrorContent.Heading);
    expect(this.getErrorText1()).to.equal(technicalErrorContent.SubHeading);
    expect(this.getErrorText2()).to.equal(technicalErrorContent.Text);
  }

  /**
   * Define ID Status Error Screen Methods
   */

  getErrorPageHeading() {
    return coreLib.getText(this.ErrorHeading);
  }

  getErrorText() {
    return coreLib.getText(this.ErrorText);
  }

  getErrorLinkText() {
    return coreLib.getAttribute(this.ErrorLink, "href");
  }

  validateIdStatusErrorPage() {
    expect(this.getErrorPageHeading()).to.equal(
      technicalErrorContent.iDErrorHeading
    );
    expect(this.getErrorText()).to.equal(technicalErrorContent.iDErrorText);
    expect(this.getErrorLinkText()).to.equal(technicalErrorContent.iDErrorLink);
  }

  /**
   * Define generic Error Screen Methods
   */

   validateGenericErrorPage() {
    expect(this.getErrorHeading()).to.equal(
      technicalErrorContent.genericErrorPageHeading
    );
    expect(this.getErrorText()).to.equal(
      technicalErrorContent.genericErrorPageText
    );
  }

  /**
   * Define Overdrawn Error Screen Methods
   */
   getErrorPageHeading() {
    return coreLib.getText(this.ErrorHeading);
  }

  getErrorText() {
    return coreLib.getText(this.ErrorText);
  }

  validateOverdrawnErrorPage() {
    expect(this.getErrorPageHeading()).to.equal(
      technicalErrorContent.overdrawnErrorHeading
    );
    expect(this.getErrorText()).to.equal(
      technicalErrorContent.overdrawnErrorText
    );
  }

  /**
   * Define Email Bounce Back Error Screen Methods
   */

  validateEmailBounceBackErrorPage() {
    expect(this.getErrorPageHeading()).to.equal(
      technicalErrorContent.emailBounceBackErrorHeading
    );
    coreLib.validateCSSProperties(this.ErrorHeading, "rgba(0,41,121,1)", "cabernetjfpro", "h1");
    expect(this.getErrorText()).to.equal(
      technicalErrorContent.emailBounceBackErrorText
    );
    coreLib.validateCSSProperties(this.ErrorText, "rgba(66,66,76,1)", "nbs", "p");
  }

  /**
   * Define technical issue Error Screen Methods
   */

  validateTechIssueErrorPage() {
    expect(this.getErrorPageHeading()).to.equal(
      technicalErrorContent.techErrorHeading
    );
    expect(this.getErrorText()).to.equal(technicalErrorContent.techErrorText);
  }


  /**
   * Define incorrect details Error Screen Methods
   */

  validateIncorrectDetailsErrorPage() {
    expect(this.getErrorPageHeading()).to.equal(
      technicalErrorContent.incorrectDetailsErrorHeading
    );
    expect(this.getErrorText()).to.equal(
      technicalErrorContent.incorrectDetailsErrorText
    );
    expect(this.getErrorLinkText()).to.equal(
      technicalErrorContent.incorrectDetailsErrorLink
    );
  }

  /**
   * Define joint account browser Error Screen Elements
   */


  get jointAccountBrowserContinue() {
    return $("[data-ref='ErrorPageContinueButton.button']");
  }

  /**
   * Define joint account browser Error Screen Methods
   */

  validateContinueButton() {
    return this.jointAccountBrowserContinue.isClickable();
  }

  validateJointAccountBrowserErrorPage() {
    expect(this.getErrorPageHeading()).to.equal(
      technicalErrorContent.jointAccountBrowserErrorHeading
    );
    expect(this.getErrorText()).to.equal(
      technicalErrorContent.jointAccountBrowserErrorText
    );
    expect(this.validateContinueButton()).to.equal(true);
  }

  /**
   * Define joint account app Error Screen Methods
   */

  validateJointAccountAppErrorPage() {
    expect(this.getErrorPageHeading()).to.equal(
      technicalErrorContent.jointAccountAppErrorHeading
    );
    expect(this.getErrorText()).to.equal(
      technicalErrorContent.jointAccountAppErrorText
    );
  }

  /**
   * Define No Accounts Found Error Screen Methods
   */

  validateNoAccountsFoundErrorPage() {
    expect(this.getErrorHeading()).to.equal(
      technicalErrorContent.noAccountsFoundErrorHeading
    );
    expect(this.getErrorText()).to.equal(
      technicalErrorContent.noAccountFoundText
    );
  }

  /**
   * Define Landing Page Error Screen Elements
   */

  get landingErrorHeading() {
    return $("[data-ref='ApplicationErrorPageHeader.heading']");
  }

  get landingErrorText() {
    return $("[data-ref='ApplicationErrorPageParagraph.text']");
  }

  /**
   * Define Landing Page Error Screen Methods
   */

  isLandingErrorPageOpen() {
    browser.waitForUrl(
      "https://nbs-banking-webapp-ipc-int.dev4.edb-a.eu-west-2.notprod.thenbs.io/application-error",
      10000
    );
    return browser.pageLoaded();
  }

  validateLandingPageErrorPage() {
    expect(coreLib.getText(this.landingErrorHeading)).to.equal(
      technicalErrorContent.landingPageErrorHeading
    );
    expect(coreLib.getText(this.landingErrorText)).to.equal(
      technicalErrorContent.landingPageErrorText
    );
  }

  /**
   * Define Product change(end screen) Error Screen Methods
   */

  validateProductChangeErrorPage() {
    expect(this.getErrorPageHeading()).to.equal(
      technicalErrorContent.productChangeErrorHeading
    );
    expect(this.getErrorText()).to.equal(
      technicalErrorContent.productChangeErrorText
    );
  }
}

export default new TechnicalErrorPage();
