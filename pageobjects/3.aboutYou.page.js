import BasePage from './base.page';
import coreLib from '../utilities/coreLibrary';
import aboutYouContent from '../contents/aboutYouContent';
import genericPage from "./genericPage.page";
import { expect } from 'chai';

class AboutYouPage extends BasePage {
    /**
     * Define About You Page Elements
     */

    get titlelabel() {
        return $('#titleFieldLabel');
    }

    get errorHeader() {
        return $("[data-ref='formErrors.messageHeader.text']");
    }

    get errorHeaderMessage1() {
        return $(
            "//span[normalize-space()='Please choose your country of birth.']"
        );
    }

    get errorHeaderMessage2() {
        return $("//span[normalize-space()='Please choose your nationality.']");
    }

    get errorHeaderMessage3() {
        return $('span=Please choose your other nationality.');
    }

    get errorHeaderMessage4() {
        return $(
            "//span[contains(text(),'Your other nationality can’t be the same as your f')]"
        );
    }

    get errorAlertMessage1() {
        return $(
            "//div[@data-ref='countryOfBirth.fieldAlerts.fieldAlerts.message']"
        );
    }

    get errorAlertMessage2() {
        return $(
            "//div[@data-ref='nationality.fieldAlerts.fieldAlerts.message']"
        );
    }

    get errorAlertMessage3() {
        return $(
            "//div[@data-ref='additionalNationality.fieldAlerts.fieldAlerts.message']"
        );
    }

    get errorAlertMessage4() {
        return $(
            "[data-ref='additionalNationality.fieldAlerts.fieldAlerts.message']"
        );
    }

    get additonalNationalityYes() {
        return $("//label[normalize-space()='Yes']");
    }

    get additonalNationalityNo() {
        return $("//label[normalize-space()='No']");
    }

    get isSelectedAdditonalNationalityNo() {
        return $(
            "[data-ref='hasSecondNationality.hasSecondNationality1.radioInput']"
        );
    }

    get isSelectedAdditonalNationalityYes() {
        return $(
            "[data-ref='hasSecondNationality.hasSecondNationality0.radioInput']"
        );
    }

    get aboutYouHeader() {
        return $('//h1[normalize-space()="About you"]');
    }

    get countryDropDown() {
        return $('#countryOfBirth');
    }

    get nationalityDropDown() {
        return $('#nationality');
    }

    get secondNationalityDropDown() {
        return $('#additionalNationality');
    }

    get countryDropDownList() {
        return $$('#countryOfBirth option');
    }

    get nationalityDropDownList() {
        return $$('#nationality option');
    }

    get secondNationalityDropDownList() {
        return $$('#additionalNationality option');
    }

    get aboutYouParagraph() {
        return $("[data-ref='gdpr.text']");
    }

    get aboutYouSubHeader() {
        //return $("//p[@data-ref='text']");
        return $("//p[@class='nel-Typography-lead-0-3-345']");
    }

    get aboutYouGDPRLink() {
        return $("[data-ref='gdpr.link']");
    }

    get aboutYouQuestion1() {
        return $("//span[contains(text(),'Your country of birth')]");
    }

    get aboutYouQuestion2() {
        return $("//span[contains(text(),'Your nationality')]");
    }

    get aboutYouQuestion3() {
        return $(
            "//span[normalize-space()='Do you have another nationality?']"
        );
    }

    get checkYourDetailsHeader() {
        return $("//h2[normalize-space()='Check your details']");
    }

    get checkYourDetailsParagraph() {
        return $(
            "//p[contains(text(),'Please check this information is correct so we can')]"
        );
    }

    get heading3() {
        return $("//h3[normalize-space()='Your contact details']");
    }

    get titleField() {
        return $("//div[@data-ref='cardBody']/dl[1]/dt/p/strong");
    }

    get titleValue() {
        return $("//div[@data-ref='cardBody']/dl[1]/dd/p");
    }

    get firstNameField() {
        return $("//div[@data-ref='cardBody']/dl[2]/dt/p/strong");
    }

    get firstNameValue() {
        return $("//div[@data-ref='cardBody']/dl[2]/dd/p");
    }

    get lastNameField() {
        return $("//div[@data-ref='cardBody']/dl[3]/dt/p/strong");
    }

    get lastNameValue() {
        return $("//div[@data-ref='cardBody']/dl[3]/dd/p");
    }

    get dobField() {
        return $("//div[@data-ref='cardBody']/dl[4]/dt/p/strong");
    }

    get dobValue() {
        return $("//div[@data-ref='cardBody']/dl[4]/dd/p");
    }

    get emailField() {
        return $("//div[@data-ref='cardBody']/dl[5]/dt/p/strong");
    }

    get emailValue() {
        return $("//div[@data-ref='cardBody']/dl[5]/dd/p");
    }

    get mobileField() {
        return $("//div[@data-ref='cardBody']/dl[6]/dt/p/strong");
    }

    get mobileValue() {
        return $("//div[@data-ref='cardBody']/dl[6]/dd/p");
    }

    get landlineField() {
        return $("//div[@data-ref='cardBody']/dl[7]/dt/p/strong");
    }

    get landlineValue() {
        return $("//div[@data-ref='cardBody']/dl[7]/dd/p");
    }

    get contactDetailsFooterLine1() {
        return $("//div[@data-ref='cardFooter']/p/strong");
    }

    get contactDetailsFooterLine2() {
        return $("//div[@data-ref='cardFooter']/p[2]");
    }

    get contactDetailsFooterLine3() {
        return $("//div[@data-ref='cardFooter']/p[3]/a/span");
    }

    get contactDetailsHperLink() {
        return $("//a[@data-ref='link']");
    }

    get heading4() {
        return $("//h3[normalize-space()='Your address']");
    }

    get checkYourAddressParagraph() {
        return $(
            "//p[contains(text(),'We’ll send your new account details to this addres')]"
        );
    }

    get addressText() {
        return $("(//div[@data-ref='cardBody'])[2]/dl/dt/p/strong");
    }

    get addressLine1Part1() {
        return $("(//div[@data-ref='cardBody'])[2]/dl/dd/div/span[1]");
    }

    get addressLine1Part2() {
        return $("(//div[@data-ref='cardBody'])[2]/dl/dd/div/span[2]");
    }

    get addressLine2() {
        return $("(//div[@data-ref='cardBody'])[2]/dl/dd/div/span[3]");
    }

    get addressLine3() {
        return $("(//div[@data-ref='cardBody'])[2]/dl/dd/div/span[4]");
    }

    get addressLine4() {
        return $("(//div[@data-ref='cardBody'])[2]/dl/dd/div/span[5]");
    }

    get addressFooterLine1() {
        return $("(//div[@data-ref='cardFooter'])[2]/p/strong");
    }

    get addressFooterLine2() {
        return $("(//div[@data-ref='cardFooter'])[2]/p[2]");
    }

    get yourDetailsPhoneNo() {
        return $('.nel-YourDetails-phoneNumber-0-3-437');
    }

    /*************************
     * About You Page Methods
     *************************/

    /******************
     * Action Methods
     ******************/

    isOpen() {
        expect(browser.getUrl()).to.not.equal('https://nbs-banking-webapp-ipc-int.dev4.edb-a.eu-west-2.notprod.thenbs.io/error', 'Journey failed to start, usually due to JWT duplication.')
        browser.waitForUrl(
            'https://nbs-banking-webapp-ipc-int.dev4.edb-a.eu-west-2.notprod.thenbs.io/about-you',
            30000
        );
        return browser.pageLoaded();
    }

    selectCountryOfBirth(value) {
        coreLib.selectDropDownByValue(this.countryDropDown, value);
    }

    selectNationality(value) {
        coreLib.selectDropDownByValue(this.nationalityDropDown, value);
    }

    selectSecondNationality(value) {
        if (value) {
            coreLib.selectDropDownByValue(
                this.secondNationalityDropDown,
                value
            );
        }
    }

    selectDoYouHaveAnotherNationalityYes() {
        coreLib.selectRadio(this.additonalNationalityYes);
    }

    selectDoYouHaveAnotherNationalityNo() {
        coreLib.selectRadio(this.additonalNationalityNo);
    }

    navigateToYourTaxPage() {
        expect(this.isOpen()).to.equal(true);
        this.selectCountryOfBirth("United Kingdom");
        this.selectNationality("British");
        this.selectDoYouHaveAnotherNationalityNo();
        genericPage.clickContinueButton();
    }

    /******************
     * Validation Methods
     ******************/

    validateSecondNationalityList() {
        let list = this.secondNationalityDropDownList;
        expect(list).to.have.lengthOf(222);
    }

    validateNationalityList() {
        let list = this.nationalityDropDownList;
        expect(list).to.have.lengthOf(222);
    }

    validateCountryOfBirthList() {
        let list = this.countryDropDownList;
        expect(list).to.have.lengthOf(259);
    }

    validateSameNationalityErrorMessage() {
        let error4 = coreLib.getText(this.errorHeaderMessage4);
        expect(error4).to.equal(aboutYouContent.error4);
    }

    validateSameNationalityAlertMessage() {
        let error4 = coreLib.getText(this.errorAlertMessage4);
        expect(error4).to.equal(aboutYouContent.alertMessage4);
    }

    contentValidation() {
        let paragraphContent = coreLib.getText(this.aboutYouParagraph);
        expect(paragraphContent).to.equal(aboutYouContent.Text1);
        let subHeader = coreLib.getText(this.aboutYouSubHeader);
        expect(subHeader).to.equal(aboutYouContent.SubHeading);
        let question1 = coreLib.getText(this.aboutYouQuestion1);
        expect(question1).to.equal(aboutYouContent.Text2);
        let question2 = coreLib.getText(this.aboutYouQuestion2);
        expect(question2).to.equal(aboutYouContent.Text3);
        let question3 = coreLib.getText(this.aboutYouQuestion3);
        expect(question3).to.equal(aboutYouContent.Text4);
        let link = coreLib.getAttribute(this.aboutYouGDPRLink, 'href');
        expect(link).to.equal(aboutYouContent.Link);
    }

    errorMessageHeaderValidation() {
        let errorHeader = coreLib.getText(this.errorHeader);
        expect(errorHeader).to.equal(aboutYouContent.errorHead);
        let error1 = coreLib.getText(this.errorHeaderMessage1);
        expect(error1).to.equal(aboutYouContent.error1);
        let error2 = coreLib.getText(this.errorHeaderMessage2);
        expect(error2).to.equal(aboutYouContent.error2);
        let error3 = coreLib.getText(this.errorHeaderMessage3);
        expect(error3).to.equal(aboutYouContent.error3);
    }

    errorAlertMessageValidation() {
        let error1 = coreLib.getText(this.errorAlertMessage1);
        expect(error1).to.equal(aboutYouContent.alertMessage1);
        let error2 = coreLib.getText(this.errorAlertMessage2);
        expect(error2).to.equal(aboutYouContent.alertMessage2);
        let error3 = coreLib.getText(this.errorAlertMessage3);
        expect(error3).to.equal(aboutYouContent.alertMessage3);
    }

    yourContactDetailsValidation(
        title,
        firstName,
        lastName,
        dateOfBirth,
        email,
        mobile,
        landline
    ) {
        let yourDetailsParagraph = coreLib.getText(
            this.checkYourDetailsParagraph
        );
        expect(yourDetailsParagraph).to.equal(aboutYouContent.Text5);
        let contactDetailsHeading = coreLib.getText(this.heading3);
        expect(contactDetailsHeading).to.equal(aboutYouContent.heading3);
        let titleDetail = coreLib.getText(this.titleField);
        expect(titleDetail).to.equal(aboutYouContent.title);
        let titleDetailValue = coreLib.getText(this.titleValue);
        expect(titleDetailValue).to.equal(title);
        let firstNameDetail = coreLib.getText(this.firstNameField);
        expect(firstNameDetail).to.equal(aboutYouContent.firstName);
        let firstNameDetailValue = coreLib.getText(this.firstNameValue);
        expect(firstNameDetailValue).to.equal(firstName);
        let lastNameDetail = coreLib.getText(this.lastNameField);
        expect(lastNameDetail).to.equal(aboutYouContent.lastName);
        let lastNameDetailValue = coreLib.getText(this.lastNameValue);
        expect(lastNameDetailValue).to.equal(lastName);
        let dobDetail = coreLib.getText(this.dobField);
        expect(dobDetail).to.equal(aboutYouContent.dob);
        let dobDetailValue = coreLib.getText(this.dobValue);
        expect(dobDetailValue).to.equal(dateOfBirth);
        let emailDetail = coreLib.getText(this.emailField);
        expect(emailDetail).to.equal(aboutYouContent.email);
        let emailDetailValue = coreLib.getText(this.emailValue);
        expect(emailDetailValue).to.equal(email);
        let mobileDetail = coreLib.getText(this.mobileField);
        expect(mobileDetail).to.equal(aboutYouContent.mobileNo);
        let mobileDetailValue = coreLib.getText(this.mobileValue);
        expect(mobileDetailValue).to.equal(mobile);
        let landlineDetail = coreLib.getText(this.landlineField);
        expect(landlineDetail).to.equal(aboutYouContent.landlineNo);
        let landlineDetailValue = coreLib.getText(this.landlineValue);
        expect(landlineDetailValue).to.equal(landline);
        let contactDetailsFooter1 = coreLib.getText(
            this.contactDetailsFooterLine1
        );
        expect(contactDetailsFooter1).to.equal(
            aboutYouContent.detailsFooterLine1
        );
        let contactDetailsFooter2 = coreLib.getText(
            this.contactDetailsFooterLine2
        );
        expect(contactDetailsFooter2).to.equal(
            aboutYouContent.detailsFooterLine2
        );
        let contactDetailsFooter3 = coreLib.getText(
            this.contactDetailsFooterLine3
        );
        expect(contactDetailsFooter3).to.equal(
            aboutYouContent.detailsFooterLine3
        );
        let link = coreLib.getAttribute(this.contactDetailsHperLink, 'href');
        expect(link).to.contain(aboutYouContent.Link2);
    }

    yourAddressValidation(
        addressLine1,
        addressLine2,
        addressLine3,
        addressLine4
    ) {
        let yourAddressHeading = coreLib.getText(this.heading4);
        expect(yourAddressHeading).to.equal(aboutYouContent.heading4);
        let addressParagraph = coreLib.getText(this.checkYourAddressParagraph);
        expect(addressParagraph).to.equal(aboutYouContent.Text6);
        let addressTextField = coreLib.getText(this.addressText);
        expect(addressTextField).to.equal(aboutYouContent.subHeading4);
        let addrLine1Part1 = coreLib.getText(this.addressLine1Part1);
        let addrLine1Part2 = coreLib.getText(this.addressLine1Part2);
        let addrLine1 = addrLine1Part1 + ' ' + addrLine1Part2;
        expect(addrLine1).to.equal(addressLine1);
        let addrLine2 = coreLib.getText(this.addressLine2);
        expect(addrLine2).to.equal(addressLine2);
        let addrLine3 = coreLib.getText(this.addressLine3);
        expect(addrLine3).to.equal(addressLine3);
        let addrLine4 = coreLib.getText(this.addressLine4);
        expect(addrLine4).to.equal(addressLine4);
        let addrFooter1 = coreLib.getText(this.addressFooterLine1);
        expect(addrFooter1).to.equal(aboutYouContent.addressFooterLine1);
        let addrFooter2 = coreLib.getText(this.addressFooterLine2);
        expect(addrFooter2).to.equal(aboutYouContent.addressFooterLine2);
    }

}
export default new AboutYouPage();
