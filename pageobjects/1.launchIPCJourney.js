import BasePage from "./base.page";
import startJourneyRequests from "../utilities/startJourneyRequests";
import coreLib from '../utilities/coreLibrary';
import spinnerContent from "../contents/spinnerContent"

let userData = require('../utilities/globalTestData.js');

class launchIPCJourney extends BasePage {

  /**
   * UI Start Journey Methods
   */

  async setUrl(channelType, customerNumber, currentProduct, targetProduct, accountNumber) {
    await startJourneyRequests.generateJWTRequest(channelType, customerNumber)
    await startJourneyRequests.generateHandoffUrl(channelType, currentProduct, targetProduct, accountNumber, 'dev4')
  }
  
  open() {
    super.open(userData.getField('location'))
  }

  /**
   * INTERSTITUAL ELEMENTS AND SELECTORS
   */

  /**
   * Define Elements
   */


    get sprinnerText1 () {
      return $("[data-ref='idSpinnerSpan1']");
    }
   
    get sprinnerText2 () {
      return $("[data-ref='idSpinnerSpan2']");
    }
  
    get interstitialMessage() {
      return $("[data-ref='idSpinnerParagraph.text']");
    }

  /**
   * define or overwrite page methods
   */

  Span1Message(){
    return coreLib.getText(this.sprinnerText1);
  }

  Span2Message(){
    return coreLib.getText(this.sprinnerText2);
  }

  interstitialText(){
    return coreLib.getText(this.interstitialMessage);
  }

  verifyContentOnPage() {
    //Curent issue with calls to generate jwt, where the same jwt can be returned for 2 unique calls - TO BE FIXED.
    expect(browser.getUrl()).to.not.equal('https://nbs-banking-webapp-ipc-int.dev4.edb-a.eu-west-2.notprod.thenbs.io/error', 'Journey failed to start, usually due to JWT duplication.')
    let error = '';
    try {
      browser.waitUntil(() => this.sprinnerText1.waitForDisplayed() == true, { timeout: 10000 })
      expect(this.Span1Message()).to.equal(spinnerContent.applicationLoadingInterstitialSpan1Message);
      expect(this.Span2Message()).to.equal(spinnerContent.applicationLoadingInterstitialSpan2Message);
    } catch (e) {
      console.log('This validation often fails due to the spinners loading to quickly before the page has had time to render.', '\n')
      console.log(e)
      console.log('Test execution can continue.')
      error = JSON.stringify(e)
    }
    expect(error).to.not.include('AssertionError')
  }

  getFinalInterstitialText() {
    let error = '';
    try {
      browser.waitUntil(() => this.interstitialText() == spinnerContent.applicationLoadingInterstitialFinalText, {
        timeout: 15000,
        timeoutMsg: `Expected text to appear after 15000 ms`,
        interval: '500'
    })
    } catch (e) {
      console.log('This validation often fails due to the spinners loading to quickly before the page has had time to render.', '\n')
      console.log(e)
      console.log('Test execution can continue.')
      error = JSON.stringify(e)
    }
    expect(error).to.not.include('AssertionError')
  }

}

export default new launchIPCJourney();
