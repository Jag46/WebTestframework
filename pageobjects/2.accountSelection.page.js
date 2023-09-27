import BasePage from './base.page';
import coreLib from '../utilities/coreLibrary';
import spinnerContent from '../contents/spinnerContent';
import accountSelectionContent from '../contents/accountSelectionContent';

class accountSelectionPage extends BasePage {
    /**
     * Define Account Selection Elements
     */

    //Content elements

    get accountSelectionHeader() {
        return $("[data-ref='accountSelectionHeading.pageHeadingTitle.heading']");
    }

    get accountSelectionSubHeader() {
        return $("[data-ref='idSubHeading.text']");
    }

    get accountSelectionh2Header() {
        return $("[data-ref='selectedAccountFieldLabel.heading']");
    }

    get firstAccountHeaderText() {
        return $("[data-ref='cardheader-0.heading']");
    }

    get firstSortCodeText() {
        return $("[data-ref='idSortCode-lbl-0.text']");
    }

    get firstSortCodeValue() {
        return $("[data-ref='idSortCode-val-0.text']");
    }
    
    get firstAccountNumberText() {
        return $("[data-ref='idAccNumber-lbl-0.text']");
    }

    get firstAccountNumberValue() {
        return $("[data-ref='idAccNumber-val-0.text']");
    }

    get firstRadioButtonText() {
        return $("[data-ref='idSelectedAccount.idSelectedAccount0.radio']");
    }

    get errorHeader() {
        return $("[data-ref='formErrors.messageHeader.text']");
    }

    get pageLevelError() {
        return $("[data-ref='selectedAccountError.linkContent']");
    }
    
    get inlineLevelError() {
        return $("#idSelectedAccountAlerts");
    }

    /**
     * Interstitial elements
     */
    

    get spinnerText1() {
        return $("[data-ref='idSpinnerSpan1']");
    }

    get spinnerText2() {
        return $("[data-ref='idSpinnerSpan2']");
    }

    get interstitialMessage() {
        return $("[data-ref='idSpinnerParagraph.text']");
    }

    /**
     * Define Account Selection Methods
     */

    verifyContentOnPage() {
        let header = coreLib.getText(this.accountSelectionHeader);
        expect(header).to.equal(accountSelectionContent.accountSelectionHeader);
        let subHeader = coreLib.getText(this.accountSelectionSubHeader);
        expect(subHeader).to.equal(accountSelectionContent.accountSelectionSubHeader);
        let h2Header = coreLib.getText(this.accountSelectionh2Header);
        expect(h2Header).to.equal(accountSelectionContent.accountSelectionh2Header);
        let accountHeader = coreLib.getText(this.firstAccountHeaderText);
        expect(accountHeader).to.equal(accountSelectionContent.firstAccountHeaderText);
        let sortCodeText  = coreLib.getText(this.firstSortCodeText);
        expect(sortCodeText).to.equal(accountSelectionContent.firstSortCodeText);
        let accountNumber  = coreLib.getText(this.firstAccountNumberText);
        expect(accountNumber).to.equal(accountSelectionContent.firstAccountNumberText);
        let radioButtonText  = coreLib.getText(this.firstRadioButtonText);
        expect(radioButtonText).to.equal(accountSelectionContent.firstRadioButtonText);
    }

    //Specific account selection will be added at a later date when it's possible to set the accounts on the page.
    accountSelection(account) {
        coreLib.selectRadio(this.firstRadioButtonText)
    }

    verifyNoAccountSelectedError() {
        let inlineError = coreLib.getText(this.inlineLevelError);
        expect(inlineError).to.equal(accountSelectionContent.noAccountSelectedError);
        let pageError = coreLib.getText(this.pageLevelError);
        expect(pageError).to.equal(accountSelectionContent.noAccountSelectedError);
        let headerError = coreLib.getText(this.errorHeader);
        expect(headerError).to.equal(accountSelectionContent.headerError);
    }

    span1Message() {
        return coreLib.getText(this.spinnerText1);
    }

    span2Message() {
        return coreLib.getText(this.spinnerText2);
    }

    interstitialText() {
        return coreLib.getText(this.interstitialMessage);
    }

    verifyAccountSelectionInterstitialTest() {
        browser.waitUntil(() => this.spinnerText1.waitForDisplayed() == true, {
            timeout: 10000
        });
        expect(this.span1Message()).to.equal(spinnerContent.accountSelectionInterstitialSpan1Message);
        expect(this.span2Message()).to.equal(spinnerContent.accountSelectionInterstitialSpan2Message);
    }

    verifyFinalAccountSelectionInterstitialText() {
        browser.waitUntil(
            () => this.interstitialText() == spinnerContent.accountSelectionInterstitialFinalText,
            {
                timeout: 30000,
                timeoutMsg: `Expected text not appered after 30000 ms`,
                interval: '500'
            }
        );
    }

    isOpen() {
        expect(browser.getUrl()).to.not.equal('https://nbs-banking-webapp-ipc-int.dev4.edb-a.eu-west-2.notprod.thenbs.io/error', 'Journey failed to start, usually due to JWT duplication.')
        browser.waitForUrl(
            'https://nbs-banking-webapp-ipc-int.dev4.edb-a.eu-west-2.notprod.thenbs.io/account-selection',
            40000
        );
        return browser.pageLoaded();
    }
}

export default new accountSelectionPage();
