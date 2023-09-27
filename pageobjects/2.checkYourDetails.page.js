import BasePage from "./base.page";
import coreLib from "../utilities/coreLibrary";
import checkYourDetailsContent from "../contents/checkYourDetailsContent";
import { expect } from "chai";
import genericPage from "../pageobjects/genericPage.page";

class CheckYourDetailsPage extends BasePage {
  /**
   * Define Check Your Details Header Elements
   */

  get stepNo() {
    return $("[data-ref='steps.text']");
  }

  get productTitle() {
    return $("[data-ref='productTitle']");
  }

  get exitApplication() {
    return $("[data-ref='exitApp.linkContent']");
  }

  /**
   * Define Check Your Details Page Elements
   */

  get pageHeading() {
    return $("[data-ref='checkYourDetails.pageHeadingTitle.heading']");
  }

  get checkYourDetailsSubHeading() {
    return $("[data-ref='checkYourDetailsHeading.text']");
  }

  get checkYourDetailsParagraph() {
    return $("[data-ref='gdpr.text']");
  }

  get checkYourDetailsGDPRLink() {
    return $("[data-ref='gdpr.link']");
  }

  get checkYourDetailsGDPRLinkContent() {
    return $("[data-ref='gdpr.linkContent']");
  }

  get yourContactDetailsHeader() {
    return $("[data-ref='cardHeader_Your contact details.heading']");
  }

  get yourContactDetailsText() {
    return $("[data-ref='contactDetailsText.text']");
  }

  get titleField() {
    return $("[data-ref='Title-title.text']");
  }

  get titleValue() {
    return $("[data-ref='Title-value.text']");
  }

  get firstNameField() {
    return $("[data-ref='First name-title.text']");
  }

  get firstNameValue() {
    return $("[data-ref='First name-value.text']");
  }

  get lastNameField() {
    return $("[data-ref='Last name-title.text']");
  }

  get lastNameValue() {
    return $("[data-ref='Last name-value.text']");
  }

  get dobField() {
    return $("[data-ref='Date of birth-title.text']");
  }

  get dobValue() {
    return $("[data-ref='Date of birth-value.text']");
  }

  get emailField() {
    return $("[data-ref='Email address-title.text']");
  }

  get emailValue() {
    return $("[data-ref='Email address-value.text']");
  }

  get mobileField() {
    return $("[data-ref='Mobile number-title.text']");
  }

  get mobileValue() {
    return $("[data-ref='Mobile number-value.text']");
  }

  get landlineField() {
    return $("[data-ref='Landline-title.text']");
  }

  get landlineValue() {
    return $("[data-ref='Landline-value.text']");
  }

  get yourAddressHeader() {
    return $("//h3[@data-ref='cardHeader_Your address.heading']");
  }

  get yourAddressText() {
    return $("[data-ref='addressText.text']");
  }

  get addressTitle() {
    return $("[data-ref='address-title.text']");
  }

  get addressLine1() {
    return $("//dd[@data-ref='addressDetails']/span[1]");
  }

  get addressLine2() {
    return $("//dd[@data-ref='addressDetails']/span[2]");
  }

  get addressLine3() {
    return $("//dd[@data-ref='addressDetails']/span[3]");
  }

  get addressLine4() {
    return $("//dd[@data-ref='addressDetails']/span[4]");
  }

  get addressLine5() {
    return $("//dd[@data-ref='addressDetails']/span[5]");
  }

  get addressLine6() {
    return $("//dd[@data-ref='addressDetails']/span[6]");
  }

  get areYourDetailsCorrect() {
    return $("[data-ref='areYourDetailsCorrect.fieldLabel']");
  }

  get yesRadioButtonState() {
    return $("[data-ref='areYourDetailsCorrect.areYourDetailsCorrect0.radioInput']");
  }

  get noRadioButtonState() {
    return $("[data-ref='areYourDetailsCorrect.areYourDetailsCorrect1.radioInput']");
  }

  get yesRadioButton() {
    return $("[data-ref='areYourDetailsCorrect.areYourDetailsCorrect0.radio']");
  }

  get noRadioButton() {
    return $("[data-ref='areYourDetailsCorrect.areYourDetailsCorrect1.radio']");
  }

  get errorAlert() {
    return $("#areYourDetailsCorrectAlerts");
  }

  get errorAlertHeading() {
    return $("#areYourDetailsCorrectAlertsHeading");
  }

  get errorMessageHeader() {
    return $("[data-ref='formErrors.messageHeader.text']");
  }

  get errorMessageLinkContent() {
    return $("[data-ref='areYourDetailsCorrectError.linkContent']");
  }

  get errorMessageLink() {
    return $("//a[@data-ref='areYourDetailsCorrectError.link']");
  }

  /*************************
   * Check Your Details Page Methods
   *************************/

  /******************
   * Action Methods
   ******************/

  isOpen() {
    expect(browser.getUrl()).to.not.equal(
      "https://nbs-banking-webapp-ipc-int.dev4.edb-a.eu-west-2.notprod.thenbs.io/error",
      "Journey failed to start, usually due to JWT duplication."
    );
    browser.waitForUrl(
      "https://nbs-banking-webapp-ipc-int.dev4.edb-a.eu-west-2.notprod.thenbs.io/check-your-details",
      40000
    );
    return browser.pageLoaded();
  }

  selectYesRadioButton() {
    coreLib.selectRadio(this.yesRadioButton);
  }

  selectNoRadioButton() {
    coreLib.selectRadio(this.noRadioButton);
  }

  navigationToYourAccountChange() {
    this.selectYesRadioButton();
    genericPage.clickContinueButton(); 
  }

  navigationToYourTaxPage() {
    this.selectYesRadioButton();
    genericPage.clickContinueButton();
  }

  /******************
   * Validation Methods
   ******************/

  contactAndAddressValidation(scenario) {
    let addrLine1 = coreLib.getText(this.addressLine1) + " " + coreLib.getText(this.addressLine2)
    let addrLine2 = coreLib.getText(this.addressLine2) + " " + coreLib.getText(this.addressLine3)

    switch (scenario.toLowerCase()) {
      case "checkyourdetails_generic":
        var customerData = coreLib.getCustomerData(scenario);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.titleValue),customerData["title"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.firstNameValue),customerData["firstName"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.lastNameValue),customerData["lastName"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.dobValue),customerData["dateOfBirth"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.emailValue),customerData["emailAddress"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.mobileValue),customerData["mobilePhoneNumber"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.landlineValue),customerData["landlinePhoneNumber"]);
    
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine1),customerData["addressLine1"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine2),customerData["addressLine2"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine3),customerData["addressLine3"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine4),customerData["postcode"]);
        break;

      case "checkyourdetails_1411111112":
        var customerData = coreLib.getCustomerData(scenario);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine1),customerData["addressLine1"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine2),customerData["addressLine2"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine3),customerData["addressLine3"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine4),customerData["postcode"]);
        break;

      case "checkyourdetails_1411111113":
        var customerData = coreLib.getCustomerData(scenario);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine1),customerData["addressLine1"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine2),customerData["addressLine2"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine3),customerData["addressLine3"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine4),customerData["postcode"]);
        break;

      case "checkyourdetails_1411111117":
        var customerData = coreLib.getCustomerData(scenario);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine1),customerData["addressLine1"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine2),customerData["addressLine2"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine3),customerData["addressLine3"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine4),customerData["postcode"]);
        break;

      case "checkyourdetails_1421111112":
        var customerData = coreLib.getCustomerData(scenario);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.titleValue),customerData["title"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.firstNameValue),customerData["firstName"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.lastNameValue),customerData["lastName"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.dobValue),customerData["dateOfBirth"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.emailValue),customerData["emailAddress"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.mobileValue),customerData["mobilePhoneNumber"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.landlineValue),customerData["landlinePhoneNumber"]);
        break;

      case "CheckYourDetails_1421111118":
        var customerData = coreLib.getCustomerData(scenario);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.titleValue),customerData["title"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.firstNameValue),customerData["firstName"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.lastNameValue),customerData["lastName"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.dobValue),customerData["dateOfBirth"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.emailValue),customerData["emailAddress"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.mobileValue),customerData["mobilePhoneNumber"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.landlineValue),customerData["landlinePhoneNumber"]);
        break;
        

      case "checkyourdetails_1421111127":
        var customerData = coreLib.getCustomerData(scenario);
        coreLib.verifyActualWithExceptedData(addrLine1 ,customerData["addressLine1"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine3),customerData["addressLine2"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine4),customerData["postcode"]);
        break;

      case "checkyourdetails_1421111133":
        var customerData = coreLib.getCustomerData(scenario);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.titleValue),customerData["title"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.firstNameValue),customerData["firstName"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.lastNameValue),customerData["lastName"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.dobValue),customerData["dateOfBirth"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.emailValue),customerData["emailAddress"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.mobileValue),customerData["mobilePhoneNumber"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.landlineValue),customerData["landlinePhoneNumber"]);
        break;

      case "checkyourdetails_1421111136":
        var customerData = coreLib.getCustomerData(scenario);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine1) ,customerData["addressLine1"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine2),customerData["addressLine2"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine3),customerData["addressLine3"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine4),customerData["postcode"]);
        break;

      case "checkyourdetails_1421111137":
        var customerData = coreLib.getCustomerData(scenario);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine1),customerData["addressLine1"]);
        coreLib.verifyActualWithExceptedData(addrLine2,customerData["addressLine2"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine4),customerData["postcode"]);
        break;

      case "checkyourdetails_1421111138":
        var customerData = coreLib.getCustomerData(scenario);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine1) ,customerData["addressLine1"]);
        coreLib.verifyActualWithExceptedData(addrLine2,customerData["addressLine2"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine4),customerData["postcode"]);
        break;

      case "checkyourdetails_1421111139":
        var customerData = coreLib.getCustomerData(scenario);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine1),customerData["addressLine1"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine2),customerData["addressLine2"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine3),customerData["addressLine3"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine4),customerData["postcode"]);
        break;

      case "checkyourdetails_1421111140":
        var customerData = coreLib.getCustomerData(scenario);
        coreLib.verifyActualWithExceptedData(addrLine1 ,customerData["addressLine1"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine3),customerData["addressLine2"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine4),customerData["postcode"]);
        break;

      case "checkyourdetails_1421111141":
        var customerData = coreLib.getCustomerData(scenario);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.titleValue),customerData["title"]);
        break;

      case "checkyourdetails_1421111142":
        var customerData = coreLib.getCustomerData(scenario);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine1),customerData["addressLine1"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine2),customerData["addressLine2"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine3),customerData["addressLine3"]);
        coreLib.verifyActualWithExceptedData(coreLib.getText(this.addressLine4),customerData["postcode"]);
        break;
    }
  }

  prepopulatedFieldsValidation(){
    let radioButtonState = (this.yesRadioButtonState).getAttribute("checked");
    expect(coreLib.isSelected(this.yesRadioButtonState)).to.equal(true);
    expect(radioButtonState).to.equal('true');
  }

  contentValidation() {
    let step = coreLib.getText(this.stepNo);
    expect(step).to.equal(checkYourDetailsContent.checkYourDetailsStep);
    let heading = coreLib.getText(this.pageHeading);
    expect(heading).to.equal(checkYourDetailsContent.pageHeading);
    let subHeading = coreLib.getText(this.checkYourDetailsSubHeading);
    expect(subHeading).to.equal(checkYourDetailsContent.subHeading);
    let paragraph = coreLib.getText(this.checkYourDetailsParagraph);
    expect(paragraph).to.equal(
      checkYourDetailsContent.checkYourDetailsParagraph
    );
    let linkContent = coreLib.getText(this.checkYourDetailsGDPRLinkContent);
    expect(linkContent).to.equal(checkYourDetailsContent.linkContent);
    let link = coreLib.getAttribute(this.checkYourDetailsGDPRLink, "href");
    expect(link).to.equal(checkYourDetailsContent.link);

    let heading2 = coreLib.getText(this.yourContactDetailsHeader);
    expect(heading2).to.equal(
      checkYourDetailsContent.yourContactDetailsHeading
    );
    let subHeading2 = coreLib.getText(this.yourContactDetailsText);
    expect(subHeading2).to.equal(
      checkYourDetailsContent.yourContactDetailsText
    );
    let titleDetail = coreLib.getText(this.titleField);
    expect(titleDetail).to.equal(checkYourDetailsContent.title);
    let firstNameDetail = coreLib.getText(this.firstNameField);
    expect(firstNameDetail).to.equal(checkYourDetailsContent.firstName);
    let lastNameDetail = coreLib.getText(this.lastNameField);
    expect(lastNameDetail).to.equal(checkYourDetailsContent.lastName);
    let dobDetail = coreLib.getText(this.dobField);
    expect(dobDetail).to.equal(checkYourDetailsContent.dob);
    let emailDetail = coreLib.getText(this.emailField);
    expect(emailDetail).to.equal(checkYourDetailsContent.email);
    let mobileDetail = coreLib.getText(this.mobileField);
    expect(mobileDetail).to.equal(checkYourDetailsContent.mobileNo);
    let landlineDetail = coreLib.getText(this.landlineField);
    expect(landlineDetail).to.equal(checkYourDetailsContent.landlineNo);

    let header3 = coreLib.getText(this.yourAddressHeader);
    expect(header3).to.equal(checkYourDetailsContent.yourAddressHeading);
    let text3 = coreLib.getText(this.yourAddressText);
    expect(text3).to.equal(checkYourDetailsContent.yourAddressText);
    let title = coreLib.getText(this.addressTitle);
    expect(title).to.equal(checkYourDetailsContent.addressTitle);

    let question = coreLib.getText(this.areYourDetailsCorrect);
    expect(question).to.equal(checkYourDetailsContent.radioButtonQuestion);
    let yes = coreLib.getText(this.yesRadioButton);
    expect(yes).to.equal(checkYourDetailsContent.radioButtonYes);
    let no = coreLib.getText(this.noRadioButton);
    expect(no).to.equal(checkYourDetailsContent.radioButtonNo);
  }

  hyperlink() {
    coreLib.click(this.checkYourDetailsGDPRLink);
    browser.pause(3000);
    browser.switchWindow(
      "https://www.nationwide.co.uk/-/assets/nationwidecouk/documents/about/how-we-are-run/cookies/how-nationwide-uses-your-information.pdf?rev=cdc58ee10f154acc840205539ec0513a"
    );

    return browser.pageLoaded();
  }

  errorMessageValidation() {
    let errorHeader = coreLib.getText(this.errorAlertHeading);
    expect(errorHeader).to.equal(checkYourDetailsContent.errorAlertHeading);
    let error1 = coreLib.getText(this.errorAlert);
    expect(error1).to.equal(checkYourDetailsContent.error);
    let error2 = coreLib.getText(this.errorMessageHeader);
    expect(error2).to.equal(checkYourDetailsContent.errorHeader);
    let error3 = coreLib.getText(this.errorMessageLinkContent);
    expect(error3).to.equal(checkYourDetailsContent.error);
    let link = coreLib.getAttribute(this.errorMessageLink, "href");
    expect(checkYourDetailsContent.errorLink).to.contain(link);
  }

  /******************
   * Complete Pages Methods
   ******************/

    completeCheckYourDetailsPage() {
      this.selectYesRadioButton();
      genericPage.clickContinueButton();
    }

}
export default new CheckYourDetailsPage();
