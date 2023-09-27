const config = require("../config/shared.config.js");
export default class BasePage {

  open(path) {
    browser.url(path);
    if (global.browser.capabilities.platformName !== 'Android') {
      if (process.env.BrowserName != "safari") {
        browser.setWindowSize(1920, 1080);
      }
    }
    browser.setTimeout({ 'implicit': config.config.waitforTimeout });
  }
}
