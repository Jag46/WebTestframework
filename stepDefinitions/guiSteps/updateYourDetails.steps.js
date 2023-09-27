import { Given, When, Then } from "@cucumber/cucumber";
import updateDetailsPage from "../../pageobjects/updateYourDetails.page";

/******************
 * Action Steps
 ******************/

/******************
 * Validation Steps
 ******************/
Then(/^I validate the content of the update your details page$/, () => {
  updateDetailsPage.contentValidation();
});
