import { expect } from "chai";
import BasePage from "../pageobjects/base.page";
import userData from "./globalTestData.js";
import apiLibrary from "./apiLibrary";

var faker = require("faker/locale/en_GB");
const https = require("https");
const config = require("../config/shared.config.js");
const fs = require("fs-extra");
let customerID;

class coreLibrary extends BasePage {
  /**
   * This method returns a CSS attribute value of a specifed element
   * @param {Element} element Element locator
   * @param {String} attributeName The attribute you would like to return
   */
  getAttribute(element, attributeName) {
    browser.waitUntil(() => element.getAttribute(attributeName) != null, {
      timeout: 5000,
      timeoutMsg: "Unable to get attribute within the timeout",
    });
    var value = element.getAttribute(attributeName);
    return value;
  }

  /**
   * This method clears any text from a specifed element
   * @param {Element} element Element locator (Should be a text field)
   */
  clearTextBoxValue(element) {
    element.setValue(new Array(element.getValue().length).fill("Backspace"));
  }

  /**
   * This method sets a value in a given element
   * @param {Element} element Element locator (Should be a text field)
   * @param {String} value Value you want to set in a field
   */
  setValue(element, value) {
    if (value != "") {
      element.waitForEnabled();
      element.setValue(new Array(element.getValue().length).fill("Backspace"));
      element.setValue(value);
    }
  }

  /**
   * This method sets a value in a given element
   * @param {Element} element Element locator (Should be a text field)
   * @param {String} value Value you want to set in a field
   */

  getValue(element){
    return element.getValue();
  }

  /**
   * This method clicks an element when it has become clickable
   * @param {Element} element Element locator
   */
  click(element) {
    element.waitForClickable();
    element.click();
  }

  /**
   * This method double clicks an element when it has become clickable
   * @param {Element} element Element locator
   */
  doubleClick(element) {
    element.waitForClickable();
    element.doubleClick();
  }

  /**
   * This method executes js against the browser in order to focus and click an element
   * @param {Element} element Element locator
   */
  focusAndClick(element) {
    browser.pause(500);
    browser.execute(function (elelocator) {
      document.querySelector(elelocator).focus();
      document.querySelector(elelocator).click();
    }, element);
    if (browser.getWindowHandles() < 2) {
      browser.execute(function (elelocator) {
        document.querySelector(elelocator).click();
      }, element);
    }
  }

  /**
   * This method waits for an element to become enabled and then clicks it
   * @param {Element} element Element locator
   */
  selectRadio(element) {
    element.waitForEnabled();
    element.click();
  }

  /**
   * This method waits for additonal the tab you want to switch to, to be fully loaded.
   * @param {String} tab  Pass tab as the name of the tab you want to switch to
   */
  waitForTabAndChange(tab) {
    browser.waitUntil(() => browser.getWindowHandles().length >= 2, {
      timeout: 10000,
      timeoutMsg: "Only one handle was avilable",
    });
    for (let i = 0; i < 3; i++) {
      try {
        browser.switchWindow(tab);
      } catch (e) {
        console.log(e);
      }
      if (browser.getTitle() == tab) {
        break;
      }
      browser.pause(3000);
    }
    let documentState = browser.execute(function () {
      return document.readyState;
    });
    browser.waitUntil(() => documentState === "complete" || "interactive", {
      timeout: 10000,
    });
  }

  /**
   * This method waits for a specified period of time.
   * @param {Int} timeOut  Passed as seconds
   */
  waitInSeconds(time) {
    browser.pause(time * 1000);
  }

  /**
   * This method returns text from a specified elemnet
   * @param {Element} element  Element locator
   */
  getText(element) {
    element.waitForDisplayed();
    return element.getText();
  }

  /**
   * This method waits a specifed amount of time for an element to be displayed
   * @param {Element} element  Element locator
   * @param {Int} time  Passed as seconds
   */
  waitforElementDisplayed(element, time) {
    element.waitForDisplayed(time * 1000);
  }

  /**
   * This method waits for an element to become enabled and then clicks it allowing the dropdown values to be accessed
   * @param {Element} element  Element locator of the dropdown
   * @param {String} value Value you want to select from the dropdown
   */
  selectDropDownByValue(element, value) {
    element.waitForEnabled();
    element.click();
    element.selectByVisibleText(value);
  }

   /**
   * This method waits for an element to become enabled and then clicks it allowing the dropdown values to be accessed
   * @param {Element} element  Element locator of the dropdown
   * @param {String} value Value you want to select from the dropdown
   */
     selectFilterableDropDownByValue(element, value) {
      element.waitForEnabled();
      element.click();
      value.click()
    }

  /**
   * This method checks an element exists in the DOM and returns a boolean
   * @param {Element} element  Element locator
   */
  isAvailable(element) {
    return element.isExisting();
  }

  /**
   * This method checks an element is selected and returns a boolean
   * @param {Element} element  Element locator
   */
  isSelected(element) {
    return element.isSelected();
  }

  /**
   * This method accepts a browser alert
   */
  acceptAlert() {
    browser.acceptAlert();
  }

  /**
   * This method switches to a specified frame in the browser object
   * @param {String} iframe  Frame idenifier
   */
  switchFrame(iframe) {
    browser.switchToFrame(iframe);
  }

  /**
   * This method switches back to the browsers parent frame
   */
  switchToParentFrame() {
    browser.switchToParentFrame();
  }

  /**
   * This method actives the browser back button
   */
  browserBack() {
    browser.back();
  }

  /**
   * This method closes the browsers window
   */
  closeWindow() {
    browser.closeWindow();
  }

  /**
   * This method switches to the browsers last window handle
   */
  switchToLastWindow() {
    browser.switchToWindow(
      browser.getWindowHandles()[browser.getWindowHandles().length - 1]
    );
  }

  async getConsoleLog(){
    return await browser.getLogs('browser')
  }

  /**
   * This method sets up a interceptor
   * @param {String} method  The HTTP Method type to be validated
   * @param {String} url     The URL of the request to be validated
   * @param {String} status  The expected status of the request
   */
  setupInterceptor(method, url, status) {
    browser.expectRequest(method, url, status)
  }

  loadJsonData(JsonFilePath) {
    process.env.EnvironmentVar = browser.config.serverUrls.environment;
    let rawdata = fs.readFileSync("test/testData/e2eScenarioTestData/" + process.env.EnvironmentVar + "/" + JsonFilePath);
    let customerData = JSON.parse(rawdata);
    rawdata = JSON.stringify(customerData);
    userData.setField("customerData", rawdata);
  }

  initializeUserTestData(JsonFilePath, scenarioName) {
    let testScenarioDataFile = fs.readFileSync("test/testData/e2eScenarioTestData/" + process.env.EnvironmentVar + "/" + JsonFilePath);

    let scenarioData = JSON.parse(testScenarioDataFile);
    scenarioData = scenarioData[scenarioName];
    scenarioData = JSON.stringify(scenarioData);
    userData.setField("customerData", scenarioData);
    console.log(scenarioName + "==>> Scenario Test Data ::" + userData.getField("customerData"));
  }

  generateCustomer(customer) {
    switch (customer) {
      case "Accept":
        this.loadJsonData("accept.json");
        break;

      default:
        customerID = customer;
        break;
    }

    if (userData.getField("CustomerID") == "") {
      userData.setField("CustomerID", customerID);
    }
    return customerID;
  }

  setCustomerData(scenario) {
    switch (scenario) {
      case "CheckYourDetails":
        this.loadJsonData("CheckYourDetails.json");
        break;
    }
  }

  loadTestData(keyItem) {
    queryStateBody = fs.readFileSync("test/testData/endtoend");
    userData.setField("customerData", userData.getField("pageLoadMsg"));
  }

  getCustomerData(panelData) {
    return JSON.parse(userData.getField("customerData"))[panelData];
  }

  waitUntilElementTextExist(element, text, timeInterval){
  browser.waitUntil(
    () => element.getText() === text,
    {
        timeout: timeInterval,
        timeoutMsg: 'expected text to be different after given time '+timeInterval+' milliseconds'
    });
  }

  getCSSProperties(element, cssProperty) {
    return element.getCSSProperty(cssProperty);
  }

  validateCSSProperties(element, expectedColor, expectedFontFamily, expectedTagName) {
    let actualColor = this.getCSSProperties(element, 'color');
    expect(actualColor.value).to.equal(expectedColor);
    let actualFontFamily = this.getCSSProperties(element, 'font-family');
    expect(actualFontFamily.value).to.equal(expectedFontFamily);
    let tagName = element.getTagName();
    expect(tagName).to.equal(expectedTagName);
  }

  randomNumber(minimum, maximum) {
    return faker.random.number({ min: minimum, max: maximum });
  }

  randomBoolean() {
    return Math.random() >= 0.5; //Probability is 50 - 50 for true and false
  }

  verifyActualWithExceptedData(actualData, exceptedData) {
    assert.equal(
      exceptedData,
      actualData,
      "Expected:" + exceptedData + ": and Actual:" + actualData + ": values are not equal"
    );
  }

  getCustomerData(panelData) {
    return JSON.parse(userData.getField("customerData"))[panelData];
  }
}
export default new coreLibrary();
