import BasePage from "./base.page";
import coreLib from "../utilities/coreLibrary";
import launchIPC from "../pageobjects/1.launchIPCJourney";
import checkYourDetailsPage from "../pageobjects/2.checkYourDetails.page.js";
import YourTaxPage from "../pageobjects/4.yourTax.page";
import YourAccountChange from "../pageobjects/5.yourAccountChange.page";
import YourAccount from "../pageobjects/6.yourAccount.page";
import importantInformationPage from "../pageobjects/7.importantInformation.page.js";
import completeYourAccountChangePage from "../pageobjects/8.completeYourAccountChange.page";

class genericPage extends BasePage {

/**
 * Define Generic Page Elements
 */

get continueButton() {
    return '[data-action="Continue"]'
}

get completeAccountChangeButton(){
    return $("[data-ref='continueButton.button']")
}

get backButton(){
    return $("[data-ref='components.buttons.backBtn.linkContent']")
}

get stepText() {
    return $("[data-ref='steps.text']");
}

/******************
* Action Methods
******************/

clickContinueButton () {
    coreLib.focusAndClick(this.continueButton);
}

clickBackButton () {
    coreLib.click(this.backButton);
}

clickCompleteAccountChangeButton () {
    coreLib.click(this.completeAccountChangeButton);
}

}

export default new genericPage();