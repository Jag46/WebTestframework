import environmentconf from "../config/environmentdetails";
import userData from "../utilities/globalTestData.js";
class environment {
getEnv(key) {
  if (process.env.EnvironmentVar == null) {
    process.env.EnvironmentVar = browser.config.serverUrls.environment;
    userData.setField("testDataFolderPath", "./../testData/e2eScenarioTestData/"+process.env.EnvironmentVar+"/" );
    console.log('testDataFolderPath: '+ userData.getField("testDataFolderPath"));
  }
  process.env.BrowserName = global.browser.capabilities.browserName;
  let envData = environmentconf;
  return envData.environmentconfig[process.env.EnvironmentVar][key];

  }
}
export default new environment();
