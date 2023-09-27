import { Given, When, Then } from "@cucumber/cucumber";
import exitApplicationModal from '../../../pageobjects/components/exitApplicationModal.page';
import { expect } from 'chai';

Given(/^I exit the application$/, () => {
    exitApplicationModal.clickExitApplicationLink();
    exitApplicationModal.clickExitApplicationButton();
    //Added if statement below due to the slower loading on browerstack
    exitApplicationModal.isOpen();
});

Given(/^I validate the exit modal content$/, () => {
    exitApplicationModal.validateExitModalLink();
    exitApplicationModal.clickExitApplicationLink();
    exitApplicationModal.validateExitModalContent();
});

Given(/^I validate the exit modal cancel buttons$/, () => {
    exitApplicationModal.clickExitApplicationLink();
    exitApplicationModal.clickCancelExitApplicationButton()
    exitApplicationModal.clickExitApplicationLink();
    exitApplicationModal.clickCloseExitApplicationModalButton()
});
