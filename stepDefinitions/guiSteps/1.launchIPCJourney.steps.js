import { Given, When, Then } from "@cucumber/cucumber";
import launchIPC from "../../pageobjects/1.launchIPCJourney.js";

Given(/^I launch IPC journey with the following params channel type "(.*)", customer number "(.*)", current product "(.*)", target product "(.*)" and account number "(.*)"$/, async (channelType, customerNumber, currentProduct, targetProduct, accountNumber) => {
  await launchIPC.setUrl(channelType, customerNumber, currentProduct, targetProduct, accountNumber);
  //Added an interceptor to capture the requests the browser sends to the BE
  browser.setupInterceptor()
  launchIPC.open()
});

Then(/^the Interstitial page loading spinner appears$/, () => {
  launchIPC.verifyContentOnPage();
  launchIPC.getFinalInterstitialText(); 
});