import BasePage from "./base.page";
import updateYourDetailsPageContent from "../contents/updateYourDetailsPageContent";
import coreLib from "../utilities/coreLibrary";

class UpdateDetailsPage extends BasePage {
  /**
   * Define Update Your Details Page Elements
   */

  get updateDetailsPageHeading() {
    return $("[data-ref='UpdateYourDetailsPageHeading.heading']");
  }

  get updateDetailsPageSubHeading() {
    return $("[data-ref='UpdateYourDetailsPageSubHeading.text']");
  }

  get updateDetailsPageHeading2() {
    return $("[data-ref='UpdateYourDetailsPageHeading2.heading']");
  }

  get updateDetailsPageText1() {
    return $("[data-ref='UpdateYourDetailsPageText1.text']");
  }

  get updateDetailsPageLinkContent() {
    return $("[data-ref='UpdateYourDetailsPageLink1.linkContent']");
  }

  get updateDetailsPageLink() {
    return $("[data-ref='UpdateYourDetailsPageLink1.link']");
  }

  get updateDetailsPagePhoneLinkContent() {
    return $("[data-ref='UpdateYourDetailsPageLink2.linkContent']");
  }

  get updateDetailsPagePhoneLink() {
    return $("[data-ref='UpdateYourDetailsPageLink2.link']");
  }

  get updateDetailsPageHeading3() {
    return $("[data-ref='UpdateYourDetailsPageHeading3.heading']");
  }

  get updateDetailsPageText2() {
    return $("[data-ref='UpdateYourDetailsPageText2.text']");
  }

  get updateDetailsPageWarning() {
    return $("[data-ref='UpdateYourDetailsPageWarning.messageContent']");
  }

  /******************
   * Action Methods
   ******************/
  isOpen() {
    browser.waitForUrl(
      "https://nbs-banking-webapp-ipc-int.dev4.edb-a.eu-west-2.notprod.thenbs.io/update-your-details",
      10000
    );
    return browser.pageLoaded();
  }

  verifyPhoneLink() {
    coreLib.click(this.updateDetailsPagePhoneLink);
    browser.pause(2000);
  }

  /******************
   * Validation Methods
   ******************/
  contentValidation() {
    let heading = coreLib.getText(this.updateDetailsPageHeading);
    expect(heading).to.equal(
      updateYourDetailsPageContent.updateDetailsPageHeading
    );
    let subHeading = coreLib.getText(this.updateDetailsPageSubHeading);
    expect(subHeading).to.equal(
      updateYourDetailsPageContent.updateDetailsPageSubHeading
    );
    let pageHeading2 = coreLib.getText(this.updateDetailsPageHeading2);
    expect(pageHeading2).to.equal(
      updateYourDetailsPageContent.updateDetailsPageHeading2
    );
    let pageHeading3 = coreLib.getText(this.updateDetailsPageHeading3);
    expect(pageHeading3).to.equal(
      updateYourDetailsPageContent.updateDetailsPageHeading3
    );
    let pageText1 = coreLib.getText(this.updateDetailsPageText1);
    expect(pageText1).to.equal(
      updateYourDetailsPageContent.updateDetailsPageText1
    );
    let pageText2 = coreLib.getText(this.updateDetailsPageText2);
    expect(pageText2).to.equal(
      updateYourDetailsPageContent.updateDetailsPageText2
    );
    let pageWarningText = coreLib.getText(this.updateDetailsPageWarning);
    expect(pageWarningText).to.equal(
      updateYourDetailsPageContent.updateYourDetailsPageWarning
    );
    let linkContent = coreLib.getText(this.updateDetailsPageLinkContent);
    expect(linkContent).to.equal(
      updateYourDetailsPageContent.updateDetailsPageLinkText
    );
    let link = coreLib.getAttribute(this.updateDetailsPageLink, "href");
    expect(link).to.equal(updateYourDetailsPageContent.updateDetailsPageLink);
    let phoneLinkContent = coreLib.getText(
      this.updateDetailsPagePhoneLinkContent
    );
    expect(phoneLinkContent).to.equal(
      updateYourDetailsPageContent.updateYourDetailsPagePhoneLinkText
    );
    let phoneLink = coreLib.getAttribute(
      this.updateDetailsPagePhoneLink,
      "href"
    );
    expect(phoneLink).to.equal(
      updateYourDetailsPageContent.updateYourDetailsPagePhoneLink
    );
  }
}

export default new UpdateDetailsPage();
