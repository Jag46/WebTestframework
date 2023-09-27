import { Given, When, Then } from "@cucumber/cucumber";
import coreLib from "../../utilities/coreLibrary.js";
import genericPage from "../../pageobjects/genericPage.page";
import TechnicalErrorPage from "../../pageobjects/ipcError.page.js";
import accountSelectionPage from "../../pageobjects/2.accountSelection.page";
import checkYourDetailsPage from "../../pageobjects/2.checkYourDetails.page.js";
import YourTaxPage from "../../pageobjects/4.yourTax.page";
import YourAccountChange from "../../pageobjects/5.yourAccountChange.page";
import YourAccount from "../../pageobjects/6.yourAccount.page";
import updateDetailsPage from "../../pageobjects/updateYourDetails.page";
import importantInformationPage from "../../pageobjects/7.importantInformation.page.js";
import completeYourAccountChangePage from "../../pageobjects/8.completeYourAccountChange.page";
import endScreenPage from "../../pageobjects/9.endScreen.page";
import userData from "./../../utilities/globalTestData.js";
import apiLibrary from "../../utilities/apiLibrary";
import { assert, expect } from "chai";

Then(/^"(.*)" page is displayed$/, (page) => {
  switch (page.toLowerCase()) {
    case "accountselection":
      expect(accountSelectionPage.isOpen()).to.equal(true);
      break;
    case "yourtax":
      expect(YourTaxPage.isOpen()).to.equal(true);
      break;
    case "youraccountchange":
      expect(YourAccountChange.isOpen()).to.equal(true);
      break;
    case "errorpage":
      expect(TechnicalErrorPage.isErrorPageOpen()).to.equal(true);
      break;
    case "landingerrorpage":
      expect(TechnicalErrorPage.isLandingErrorPageOpen()).to.equal(true);
      break;
    case "checkyourdetails":
      expect(checkYourDetailsPage.isOpen()).to.equal(true);
      //Added an Interceptor that stores AppId to a global value
      browser.getRequests().forEach(element => {
        if(element.url.includes("/customer")) {
          let requiredURL = element.url;
          const appIdText = requiredURL.split("/");
          userData.setField("appId", appIdText[7]);
          let applicantText = appIdText[8].split("=");
          userData.setField("applicantId", applicantText[1]);
          var AuthorizationToken = element.headers.authorization;
          userData.setField("authorization", AuthorizationToken);
          let BearerAuthToken = apiLibrary.extractDecodedPayload();
          userData.setField("x-journey-id", BearerAuthToken.claimsData.journeyId);
        }
      });
      break;
    case "updateyourdetails":
      expect(updateDetailsPage.isOpen()).to.equal(true);
      break;
    case "youraccount":
      expect(YourAccount.isOpen()).to.equal(true);
      break;
    case "importantinformation":
      expect(importantInformationPage.isOpen()).to.equal(true);
      break;
    case "completeyouraccountchange":
      expect(completeYourAccountChangePage.isOpen()).to.equal(true);
      break;
    case "endscreen":
      expect(endScreenPage.isOpen()).to.equal(true);
      break;
    default:
      console.error(`SCRIPT ERROR: ${page} is not a valid page identifier`);
      expect(true).to.equal(false);
  }
});

Then(/^click hyperlink in "(.*)" and validate the url in new tab$/, (page) => {
  switch (page.toLowerCase()) {
    case "checkyourdetails":
      expect(checkYourDetailsPage.hyperlink()).to.equal(true);
      browser.switchWindow(
        "https://nbs-banking-webapp-ipc-int.dev4.edb-a.eu-west-2.notprod.thenbs.io/check-your-details"
      );
      break;
  }
});

Then(/^I close the IPC application$/, () => {
  browser.closeWindow();
  browser.switchWindow("IPC TOKEN Generator");
});

Then(/^I click the continue button$/, { wrapperOptions: { retry: 2 } }, () => {
  genericPage.clickContinueButton();
});

Then(/^I click the back button$/, { wrapperOptions: { retry: 2 } }, () => {
  genericPage.clickBackButton();
});

Then(
  /^I should see the window title as "(.*)" opened in the same window/,
  (expectedValue) => {
    let windowHandles = browser.getWindowHandles();
    assert.equal(
      browser.switchWindow(windowHandles.value[0]).getTitle(),
      expectedValue,
      "Actual Value : " +
        browser.switchWindow(windowHandles.value[0]).getTitle() +
        "\n" +
        "Expected Value : " +
        expectedValue +
        "\n" +
        "Actual and Expected not matched"
    );
  }
);

Then(/^I should see the window title as "(.*)"/, (expectedValue) => {
  assert.equal(
    browser.getTitle(),
    expectedValue,
    "Actual Value : " +
      browser.getTitle() +
      "\n" +
      "Expected Value : " +
      expectedValue +
      "\n" +
      "Actual and Expected not matched"
  );
});

Then(
  /^I should see the window title "(.*)" opened in the new tab/,
  (expectedValue) => {
    browser.switchToWindow(
      browser.getWindowHandles()[browser.getWindowHandles().length - 1]
    );
    expect(browser.getTitle().toString()).to.equal(expectedValue);
    browser.closeWindow();
    browser.switchToWindow(
      browser.getWindowHandles()[browser.getWindowHandles().length - 1]
    );
  }
);

Given(/^I set customer data for scenario "(.*)"/, (scenario) => {
  coreLib.setCustomerData(scenario);
});

Given(
  /^I set "(.*)" customer data for scenario "(.*)"/,
  (testDataFileName, testScenario) => {
    coreLib.initializeUserTestData(testDataFileName + ".json", testScenario);
  }
);

Given(
  /^I setup the interceptor for "(.*)" method, "(.*)" url and (\d+) response/,
  (method, url, status) => {
    if(url.toLowerCase().includes("{appid}") === true) {
      url = url.replace('{appId}', userData.getField('appId'))
    }
    if(url.toLowerCase().includes("{applicantid}") === true) {
      url = url.replace('{applicantId}', userData.getField('applicantId'))
    }
    coreLib.setupInterceptor(method.toUpperCase(), url, status);
  }
);

Given(
  /^I validate the interceptor/,
  () => {
        for (let i = 0; i < 4; i++) {
          if (browser.getRequests().length !== 0) {
            break;
          } 
          browser.pause(500)
        }
    browser.assertExpectedRequestsOnly()
  }
);

Given(
  /^I validate a call to "(.*)" was made (\d+) times/,
  (endpoint, amount) => {
        for (let i = 0; i < 4; i++) {
          if (browser.getRequests().length !== 0) {
            break;
          } 
          browser.pause(500)
        }
        const browserRequests = browser.getRequests()
        let i = 0
        browserRequests.forEach(element => {
          if(JSON.stringify(element).includes(endpoint)){
            i++
          }
        })
    assert.equal(i, amount)
  }
);