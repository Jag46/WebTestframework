import BasePage from "./base.page";
import coreLib from "../utilities/coreLibrary";
import yourTaxContent from "../contents/yourTaxContent";
import genericPage from "../pageobjects/genericPage.page";

class YourTaxPage extends BasePage {
    /**
     * Define Your Tax Page Elements
     */

    isOpen() {
        browser.waitForUrl('https://nbs-banking-webapp-ipc-int.dev4.edb-a.eu-west-2.notprod.thenbs.io/your-tax', 10000)
        return browser.pageLoaded();
    }

    /**
     * Content Elements
     */

    get titlelabel() {
        return $("[data-ref='taxHeading.pageHeadingTitle.heading']");
    }

    get subHeading() {
        return $("[data-ref='idTaxSubHeading.text']");
    }

    get liableText() {
        return $("[data-ref='areYouTaxLiable.fieldLabel']");
    }

    get liableDescription() {
        return $("#areYouTaxLiableDescription");
    }

    get citizenText() {
        return $("#areYouCitizenOfUSAFieldLabel");
    }

    get TaxPayOtherCountryText() {
        return $("#areYouTaxPayerOfOtherCountryFieldLabel");
    }

    get tinText() {
        return $("#yourTaxTinFieldLabel");
    }

    get getUSTinText(){
        return $("#yourTaxTin");
    }

    get countryOfTax1Heading() {
        return $("[data-ref='countryOfTaxPay0.heading']");
    }

    get countryOfTax1Text() {
        return $("[data-ref='countryOfTaxPay0.text']");
    }

    get countryOfTax1TinText() {
        return $("[data-ref='otherCountryTaxTin0.text']");
    }

    get countryOfTax2Heading() {
        return $("[data-ref='countryOfTaxPay1.heading']");
    }

    get countryOfTax2Text() {
        return $("[data-ref='countryOfTaxPay1.text']");
    }

    get countryOfTax2TinText() {
        return $("[data-ref='otherCountryTaxTin1.text']");
    }

    get countryOfTax3Heading() {
        return $("[data-ref='countryOfTaxPay2.heading']");
    }

    get countryOfTax3Text() {
        return $("[data-ref='countryOfTaxPay2.text']");
    }

    get countryOfTax3TinText() {
        return $("[data-ref='otherCountryTaxTin2.text']");
    }

    get countryOfTaxError1() {
        return $("#countryOfTaxPay0Alerts");
    }

    get countryOfTaxError2() {
        return $("#countryOfTaxPay1Alerts");
    }

    get countryOfTaxError3() {
        return $("#countryOfTaxPay2Alerts");
    }

    get errorTaxPayOtherCountryQue() {
        return $("#areYouTaxPayerOfOtherCountryAlerts");
    }

    get errorMessageHeader() {
        return $("[data-ref='formErrors.messageHeader.text']");
    }

    get errorResidentForTaxPurposeHeaderText() {
        return $("span=You told us you’re liable to pay tax in another country. Please check the information you’ve provided is correct.");
    }

    get errorResidentForTaxPurposeHeaderLink() {
        return $("//div[@data-ref='formErrors.messageContent']/ul/li/a");
    }

    get errorTaxLiableHeaderText() {
        return $("span=Please tell us if you're liable to pay tax in another country.");
    }

    get errorResidentForTaxPurposeHeaderText() {
        return $("span=You told us you’re liable to pay tax in another country. Please check the information you’ve provided is correct.");
    }

    get errorUnselectedUSCitizen() {
        return $("#areYouCitizenOfUSAAlerts");
    }

    get errorUnselectedUSCitizenHeaderText() {
        return $("span=Please tell us if you’re a United States (US) citizen.");
    }

    get errorUnselectedTaxResident() {
        return $("#areYouTaxPayerOfOtherCountryAlerts");
    }

    get errorUnselectedTaxResidentHeaderText() {
        return $("span=Please tell us if you're a resident for tax purposes in any other country other than the United Kingdom.");
    }

    get errorTIN() {
        return $("#yourTaxTinAlerts");
    }

    get errorTINInvalidHeaderText() {
        return $("span=Please enter your TIN correctly using letters, numbers and hyphens, where applicable.");
    }

    get errorTINTooLongHeaderText() {
        return $("span=Please enter your TIN correctly - it needs to be between 1 and 20 characters.");
    }

    get errorUnselectedCountryHeaderText() {
        return $("span=Please select which country you pay tax in.");
    }

    get errorAnotherUSCountry() {
        return $("#countryOfTaxPay0Alerts");
    }

    get errorAnotherUSCountryHeaderText() {
        return $("span=You’ve already told us you’re a US citizen. Please choose a different country from the list. Or, change your answer for US citizenship to ‘no’.");
    }

    get errorOtherCountriesAreTheSame() {
        return $("[data-ref='countryOfTaxPay1.fieldAlerts.fieldAlerts.messageContent']");
    }

    get errorOtherCountriesAreTheSameHeaderText() {
        return $("span=You can’t choose the same country more than once. Please choose another country from the list or change your choice above.");
    }
    
    /**
     * Interactive Elements
     */

    get liableQueRadioYes() {
        return $("[data-ref='areYouTaxLiable.areYouTaxLiable0.radio']");
    }

    get liableQueRadioNo() {
        return $("[data-ref='areYouTaxLiable.areYouTaxLiable1.radio']");
    }

    get liableQueRadioYesState() {
        return $("[data-ref='areYouTaxLiable.areYouTaxLiable0.radioInput']");
    }

    get liableQueRadioNoState() {
        return $("[data-ref='areYouTaxLiable.areYouTaxLiable1.radioInput']");
    }

    get usCitizenQueRadioYesState() {
        return $("[data-ref='areYouCitizenOfUSA.areYouCitizenOfUSA0.radioInput']");
    }

    get otherCountryQueRadioNoState() {
        return $("[data-ref='areYouTaxPayerOfOtherCountry.areYouTaxPayerOfOtherCountry1.radioInput']");
    }

    get citizenQueRadioYes() {
        return $("[data-ref='areYouCitizenOfUSA.areYouCitizenOfUSA0.radio'");
    }

    get citizenQueRadioNo() {
        return $("[data-ref='areYouCitizenOfUSA.areYouCitizenOfUSA1.radio'");
    }

    get TaxPayOtherCountryRadioYes() {
        return $("[data-ref='areYouTaxPayerOfOtherCountry.areYouTaxPayerOfOtherCountry0.radio'");
    }

    get TaxPayOtherCountryRadioNo() {
        return $("[data-ref='areYouTaxPayerOfOtherCountry.areYouTaxPayerOfOtherCountry1.radio'");
    }

    get tinInput() {
        return $("#yourTaxTin");
    }

    get getUSTinText() {
        return $("#yourTaxTin");
    }

    get countryOfTax1DropDown() {
        return $("#countryOfTaxPay0");
    }

    get countryOfTax1TinInput() {
        return $("#otherCountryTaxTin0");
    }

    get countryOfTax2DropDown() {
        return $("#countryOfTaxPay1");
    }

    get countryOfTax2TinInput() {
        return $("#otherCountryTaxTin1");
    }

    get countryOfTax3DropDown() {
        return $("#countryOfTaxPay2");
    }

    get countryOfTax3TinInput() {
        return $("#otherCountryTaxTin2");
    }

    get addOtherCountryButton() {
        return $("[data-ref='countryOfTaxPay.repeaterAdd.button']");
    }

    get removeButton() {
        return $("[data-ref='repeaterRemove.button']");
    }

    get backButtonLink() {
        return $("#tax.backButton");
    }

    get exitApplicationLink() {
        return $("[data-ref='linkContent']");
    }

    /*************************
     * Your Tax Page Methods
     *************************/

    /******************
     * Action Methods
     ******************/

    selectYesLiableQueRadio() {
        coreLib.click(this.liableQueRadioYes);
    }

    selectNoLiableQueRadio() {
        coreLib.click(this.liableQueRadioNo);
    }

    selectYesCitizenQueRadio() {
        coreLib.click(this.citizenQueRadioYes);
    }

    selectNoCitizenQueRadio() {
        coreLib.click(this.citizenQueRadioNo);
    }

    selectYesTaxPayOtherCountryRadio() {
        coreLib.click(this.TaxPayOtherCountryRadioYes);
    }

    selectNoTaxPayOtherCountryRadio() {
        coreLib.click(this.TaxPayOtherCountryRadioNo);
    }

    setTINForUS(value) {
        coreLib.setValue(this.tinInput, value);
    }

    setTINForCountryOne(value) {
        coreLib.setValue(this.countryOfTax1TinInput, value);
    }

    setTINForCountryTwo(value) {
        coreLib.setValue(this.countryOfTax2TinInput, value);
    }

    setTINForCountryThree(value) {
        coreLib.setValue(this.countryOfTax3TinInput, value);
    }

    selectNoTaxPayOtherCountryRadio() {
        coreLib.click(this.TaxPayOtherCountryRadioNo);
    }

    setTINForUS(value) {
        coreLib.setValue(this.tinInput, value);
    }

    setINForCountryOne(value) {
        coreLib.setValue(this.countryOfTax1TinInput, value);
    }

    setINForCountryTwo(value) {
        coreLib.setValue(this.countryOfTax2TinInput, value);
    }

    setINForCountryThree(value) {
        coreLib.setValue(this.countryOfTax3TinInput, value);
    }

    clickAddAnotherCountryButton() {
        coreLib.click(this.addOtherCountryButton);
    }

    setPartialValueOnCountryOne(value) {
        coreLib.setValue(this.countryOfTax1DropDown, value)
    }

    otherCountryOne(value) {
        const listItem = $(`//ul[@id='countryOfTaxPay0-options']//li[text()='${value}']`)
        coreLib.selectFilterableDropDownByValue(this.countryOfTax1DropDown, listItem)
    }

    otherCountryTwo(value) {
        const listItem = $(`//ul[@id='countryOfTaxPay1-options']//li[text()='${value}']`)
        coreLib.selectFilterableDropDownByValue(this.countryOfTax2DropDown, listItem)
    }

    otherCountryThree(value) {
        const listItem = $(`//ul[@id='countryOfTaxPay2-options']//li[text()='${value}']`)
        coreLib.selectFilterableDropDownByValue(this.countryOfTax3DropDown, listItem)
    }

    navigationToYourAccountChangePage() {
        this.selectNoLiableQueRadio();
        genericPage.clickContinueButton();
    }


    /******************
     * Validation Methods
     ******************/

    validateContent() {
        let title = coreLib.getText(this.titlelabel);
        expect(title).to.equal(yourTaxContent.heading);
        let subHeading = coreLib.getText(this.subHeading);
        expect(subHeading).to.equal(yourTaxContent.subHeading);
        let liableQuestion = coreLib.getText(this.liableText);
        expect(liableQuestion).to.equal(yourTaxContent.question1);
        let liableQuestionDescription = coreLib.getText(this.liableDescription);
        expect(liableQuestionDescription).to.equal(yourTaxContent.question1desc);
        let citizenQuestion = coreLib.getText(this.citizenText);
        expect(citizenQuestion).to.equal(yourTaxContent.question2);
        let taxPayOtherCountryQuestion = coreLib.getText(this.TaxPayOtherCountryText);
        expect(taxPayOtherCountryQuestion).to.equal(yourTaxContent.question3);

        let headingCountry1 = coreLib.getText(this.countryOfTax1Heading);
        expect(headingCountry1).to.equal(yourTaxContent.country1Heading);
        let textCountry1 = coreLib.getText(this.countryOfTax1Text);
        expect(textCountry1).to.equal(yourTaxContent.countryText);
        let textTINCountry1 = coreLib.getText(this.countryOfTax1TinText);
        expect(textTINCountry1).to.equal(yourTaxContent.countryTINText);

        let headingCountry2 = coreLib.getText(this.countryOfTax2Heading);
        expect(headingCountry2).to.equal(yourTaxContent.country2Heading);
        let textCountry2 = coreLib.getText(this.countryOfTax2Text);
        expect(textCountry2).to.equal(yourTaxContent.countryText);
        let textTINCountry2 = coreLib.getText(this.countryOfTax2TinText);
        expect(textTINCountry2).to.equal(yourTaxContent.countryTINText);

        let headingCountry3 = coreLib.getText(this.countryOfTax3Heading);
        expect(headingCountry3).to.equal(yourTaxContent.country3Heading);
        let textCountry3 = coreLib.getText(this.countryOfTax3Text);
        expect(textCountry3).to.equal(yourTaxContent.countryText);
        let textTINCountry3 = coreLib.getText(this.countryOfTax3TinText);
        expect(textTINCountry3).to.equal(yourTaxContent.countryTINText);
    }

    validateSelectedNoResidentForTaxPurposeError() {
        let error1 = coreLib.getText(this.errorTaxPayOtherCountryQue);
        expect(error1).to.equal(yourTaxContent.taxResidentError);

        let errorHeader = coreLib.getText(this.errorMessageHeader);
        expect(errorHeader).to.equal(yourTaxContent.oneErrorMessageHeader);

        let errorHeaderText = coreLib.getText(this.errorResidentForTaxPurposeHeaderText);
        expect(errorHeaderText).to.equal(yourTaxContent.taxResidentError);

        //Removing until appropiate selectors have been created.
        // let link = coreLib.getAttribute(this.errorResidentForTaxPurposeHeaderLink, 'href');
        // expect(link).to.equal(yourTaxContent.question3ErrorHeaderLink);
    }

    validateUnselectedLiableForTaxError() {
        let error1 = coreLib.getText(this.errorTaxLiable);
        expect(error1).to.equal(yourTaxContent.unselectedTaxLiableError);

        let errorHeader = coreLib.getText(this.errorMessageHeader);
        expect(errorHeader).to.equal(yourTaxContent.oneErrorMessageHeader);

        let errorHeaderText = coreLib.getText(this.errorTaxLiableHeaderText);
        expect(errorHeaderText).to.equal(yourTaxContent.unselectedTaxLiableError);

        //Removing until appropiate selectors have been created.
        // let link = coreLib.getAttribute(this.errorResidentForTaxPurposeHeaderLink, 'href');
        // expect(link).to.equal(yourTaxContent.question1ErrorHeaderLink);
    }

    validateUnselectedUSCitizenError() {
        let error1 = coreLib.getText(this.errorUnselectedUSCitizen);
        expect(error1).to.equal(yourTaxContent.unselectedUSCitizenError);

        let errorHeader = coreLib.getText(this.errorMessageHeader);
        expect(errorHeader).to.equal(yourTaxContent.twoErrorMessageHeader);

        let errorHeaderText = coreLib.getText(this.errorUnselectedUSCitizenHeaderText);
        expect(errorHeaderText).to.equal(yourTaxContent.unselectedUSCitizenError);

        //Removing until appropiate selectors have been created.
        // let link = coreLib.getAttribute(this.errorResidentForTaxPurposeHeaderLink, 'href');
        // expect(link).to.equal(yourTaxContent.question1ErrorHeaderLink);
    }

    validateUnselectedTaxResidentError() {
        let error1 = coreLib.getText(this.errorUnselectedTaxResident);
        expect(error1).to.equal(yourTaxContent.unselectedTaxResidentError);

        let errorHeader = coreLib.getText(this.errorMessageHeader);
        expect(errorHeader).to.equal(yourTaxContent.twoErrorMessageHeader);

        let errorHeaderText = coreLib.getText(this.errorUnselectedTaxResidentHeaderText);
        expect(errorHeaderText).to.equal(yourTaxContent.unselectedTaxResidentError);

        //Removing until appropiate selectors have been created.
        // let link = coreLib.getAttribute(this.errorResidentForTaxPurposeHeaderLink, 'href');
        // expect(link).to.equal(yourTaxContent.question1ErrorHeaderLink);
    }

    validateInvalidTinError() {
        let error1 = coreLib.getText(this.errorTIN);
        expect(error1).to.equal(yourTaxContent.invalidTINError);

        let errorHeader = coreLib.getText(this.errorMessageHeader);
        expect(errorHeader).to.equal(yourTaxContent.twoErrorMessageHeader);

        let errorHeaderText = coreLib.getText(this.errorTINInvalidHeaderText);
        expect(errorHeaderText).to.equal(yourTaxContent.invalidTINError);

        //Removing until appropiate selectors have been created.
        // let link = coreLib.getAttribute(this.errorResidentForTaxPurposeHeaderLink, 'href');
        // expect(link).to.equal(yourTaxContent.question1ErrorHeaderLink);
    }

    validateTooLongTinError() {
        let error1 = coreLib.getText(this.errorTIN);
        expect(error1).to.equal(yourTaxContent.tinTextTooLongError);

        let errorHeader = coreLib.getText(this.errorMessageHeader);
        expect(errorHeader).to.equal(yourTaxContent.twoErrorMessageHeader);

        let errorHeaderText = coreLib.getText(this.errorTINTooLongHeaderText);
        expect(errorHeaderText).to.equal(yourTaxContent.tinTextTooLongError);

        //Removing until appropiate selectors have been created.
        // let link = coreLib.getAttribute(this.errorResidentForTaxPurposeHeaderLink, 'href');
        // expect(link).to.equal(yourTaxContent.question1ErrorHeaderLink);
    }

    validateUnselectedAdditionalCountryErrors() {
        let errorHeader = coreLib.getText(this.errorMessageHeader);
        expect(errorHeader).to.equal(yourTaxContent.threeErrorMessageHeader);

        let errorHeaderText = coreLib.getText(this.errorUnselectedCountryHeaderText);
        expect(errorHeaderText).to.equal(yourTaxContent.countryTextError);

        let error1 = coreLib.getText(this.countryOfTaxError1);
        expect(error1).to.equal(yourTaxContent.countryTextError);

        let error2 = coreLib.getText(this.countryOfTaxError2);
        expect(error2).to.equal(yourTaxContent.countryTextError);

        let error3 = coreLib.getText(this.countryOfTaxError3);
        expect(error3).to.equal(yourTaxContent.countryTextError);

        //Removing until appropiate selectors have been created.
        // let link = coreLib.getAttribute(this.errorResidentForTaxPurposeHeaderLink, 'href');
        // expect(link).to.equal(yourTaxContent.question1ErrorHeaderLink);
    }

    validateAdditionalCountryEqualsUSError() {
        let error1 = coreLib.getText(this.errorAnotherUSCountry);
        expect(error1).to.equal(yourTaxContent.additionalUSCountryError);

        let errorHeader = coreLib.getText(this.errorMessageHeader);
        expect(errorHeader).to.equal(yourTaxContent.twoErrorMessageHeader);

        let errorHeaderText = coreLib.getText(this.errorAnotherUSCountryHeaderText);
        expect(errorHeaderText).to.equal(yourTaxContent.additionalUSCountryError);
    }

    validateOytherCountriesAreTheSameError() {
        let error1 = coreLib.getText(this.errorOtherCountriesAreTheSame);
        expect(error1).to.equal(yourTaxContent.otherCountriesAreTheSameError);

        let errorHeader = coreLib.getText(this.errorMessageHeader);
        expect(errorHeader).to.equal(yourTaxContent.twoErrorMessageHeader);

        let errorHeaderText = coreLib.getText(this.errorOtherCountriesAreTheSameHeaderText);
        expect(errorHeaderText).to.equal(yourTaxContent.otherCountriesAreTheSameErrorHeader);
    }

    validateNumberOfReturnedValuesInCountryDropdownOne(value) {
        const elem = browser.execute(() => this.document.getElementById("countryOfTaxPay0-options").childElementCount)
        expect(elem).to.equal(value)
    }

    validateNoCountryMatchError() {
        const error = coreLib.getText($("#countryOfTaxPay0-options"))
        expect(error).to.equal(yourTaxContent.noResultsFound)
    }

    prepopulatedFieldsValidationForNo(){
        let radioButtonState = (this.liableQueRadioNoState).getAttribute("checked");
        expect(coreLib.isSelected(this.liableQueRadioNoState)).to.equal(true);
        expect(radioButtonState).to.equal('true');
    }

    prepopulatedFieldsValidationForYes(){
        let radioButtonState = (this.liableQueRadioYesState).getAttribute("checked");
        expect(coreLib.isSelected(this.liableQueRadioYesState)).to.equal(true);
        expect(radioButtonState).to.equal('true');
        let usCitizenradioButtonState = (this.usCitizenQueRadioYesState).getAttribute("checked");
        expect(coreLib.isSelected(this.usCitizenQueRadioYesState)).to.equal(true);
        expect(usCitizenradioButtonState).to.equal('true');
        let tinUSNumber = coreLib.getValue(this.getUSTinText);
        console.log(tinUSNumber)
        expect(tinUSNumber).to.equal('TIN123456');
        let OtherCountryradioButtonState = (this.otherCountryQueRadioNoState).getAttribute("checked");
        expect(coreLib.isSelected(this.otherCountryQueRadioNoState)).to.equal(true);
        expect(OtherCountryradioButtonState).to.equal('true');
    }

    isOpen() {
        browser.waitForUrl('https://nbs-banking-webapp-ipc-int.dev4.edb-a.eu-west-2.notprod.thenbs.io/your-tax', 10000)
        return browser.pageLoaded();
    }

}

export default new YourTaxPage();