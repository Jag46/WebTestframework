require('@babel/register')
const defaultTimeoutInterval = process.env.DEBUG ? 60 * 60 * 500 : 80000;
const cucumberJson = require("wdio-cucumberjs-json-reporter").default;
const { removeSync } = require('fs-extra')
const userData = require("../utilities/globalTestData.js")
import zephyrLibrary from './../utilities/zephyr/zephyrLibrary';
import coreLib from './../utilities/coreLibrary';
import { prettifyBrowserLog } from '../utilities/debugContext'

exports.config = {
  sendResultsToZephyr: process.env.updateZephyr || false,
  perfLoggingPrefs: [
    {
      enableNetwork: true
      // enablePage?: boolean;
      // enableTimeline?: boolean;
      // tracingCategories?: boolean;
      // bufferUsageReportingInterval?: boolean;
    }
  ],
  //
  // ===================
  // Test Configurations
  // ===================
  // Define all options that are relevant for the WebdriverIO instance here
  //
  // By default WebdriverIO commands are executed in a synchronous way using
  // the wdio-sync package. If you still want to run your tests in an async way
  // e.g. using promises you can set the sync option to false.
  logLevel: process.env.debugLevel || 'silent', // Level of logging verbosity: silent | verbose | command | data | result | error | info
  coloredLogs: true, // Enables colors for log output.
  screenshotPath: "./test/reports/errorShots/", // Saves a screenshot to a given path if a command fails.
  pageLoadStrategy:"normal",
  pageLoad: '30000',
  //
  // Set a base URL in order to shorten url command calls. If your url parameter starts
  //baseUrl: 'http://localhost:8080',
  waitforTimeout: 25000, // Default timeout for all waitFor* commands.
  connectionRetryTimeout: 50000, // Default timeout in milliseconds for request if Selenium Grid doesn't send response
  connectionRetryCount: 2, // Default request retries count
  // Services take over a specific job you don't want to take care of. They enhance
  // your test setup with almost no effort. Unlike plugins, they don't add new
  // commands. Instead, they hook themselves up into the test process.
  //
  reporters: [
    "spec",
    [
      "cucumberjs-json",
      {
        jsonFolder: "test/reports/",
        language: "en",
      },
    ],
    [
      "junit",
      {
        outputDir: "test/reports/",
      },
    ],
  ],

  framework: "cucumber",
  // If you are using Cucumber you need to specify the location of your step definitions.
  cucumberOpts: {
    requireModule: ["@babel/register"],
    require: ["test/stepDefinitions/**/**.js"], // <string[]> (file/dir) require files before executing features
    backtrace: true, // <boolean> show full backtrace for errors
    //compiler: ['js:babel-core/register'], // <string[]> filetype:compiler used for processing required features
    compiler: [], // <string[]> filetype:compiler used for processing required features
    failAmbiguousDefinitions: true, // <boolean< Treat ambiguous definitions as errors
    dryRun: false, // <boolean> invoke formatters without executing steps
    failFast: false, // <boolean> abort the run on first failure
    ignoreUndefinedDefinitions: true, // <boolean> Enable this config to treat undefined definitions as warnings
    name: [], // <string[]> ("extension:module") require files with the given EXTENSION after requiring MODULE (repeatable)
    snippets: true, // <boolean> hide step definition snippets for pending steps
    format: ["pretty"], // <string[]> (type[:path]) specify the output format, optionally supply PATH to redirect formatter output (repeatable)
    colors: true, // <boolean> disable colors in formatter output
    snippets: false, // <boolean> hide step definition snippets for pending steps
    source: false, // <boolean> hide source uris
    profile: [], // <string[]> (name) specify the profile to use
    strict: true, // <boolean> fail if there are any undefined or pending steps
    tagExpression: process.env.testTags || "not @manual and not @skip", // <string> (expression) only execute the features or scenarios with tags matching the expression, see https://docs.cucumber.io/tag-expressions/
    timeout: defaultTimeoutInterval, // <number> timeout for step definitions
    tagsInTitle: false, // <boolean> add cucumber tags to feature or scenario name
    snippetSyntax: undefined // <string> specify a custom snippet syntax
  },

  //
  // =====
  // Hooks
  // =====
  // WedriverIO provides several hooks you can use to interfere with the test process in order to enhance
  // it and to build services around it. You can either apply a single function or an array of
  // methods to it. If one of them returns with a promise, WebdriverIO will wait until that promise got
  // resolved to continue.

  onPrepare: () => {
    // Remove the `test/reports` folder that holds the json and report files
    removeSync('test/reports/');
    removeSync('results/rerun/');
    removeSync('rerun.sh');
  },

  //
  // Gets executed before test execution begins. At this point you can access all global
  // variables, such as `browser`. It is the perfect place to define custom commands.
  before: function () {
    /**
     * Setup the Chai assertion framework
     */
    const chai = require("chai");
    global.expect = chai.expect;
    global.assert = chai.assert;
    global.should = chai.should();
    require('../utilities/wdioBrowserCommands/browserHelper.js');
  },

  beforeStep: function(step,context) {

  },

  afterStep: async function (step, scenario, result) {
    if(browser.config.sendResultsToZephyr !== false){
      let testData = []
      if (step.argument !== null) {
        step.argument.dataTable.rows.forEach(element => {
          element.cells.forEach(element => {
            testData.push(element.value)
          });
        });
      }
      zephyrLibrary.zephyrAfterStep(step, result, testData)
      testData = []
    }
    var isApiTest = false
    scenario.tags.forEach(element => {
      if(element.name == '@api') {
        isApiTest = true
      }
    });
    if (isApiTest != true) {
      cucumberJson.attach(await browser.takeScreenshot(), "image/png");
      const browserLog = await coreLib.getConsoleLog()
      const isLogEmpty = (
          !browserLog
          || (browserLog.length == 0)
          || (browserLog.length == 1 && browser[0] == ""));
      if (!isLogEmpty) {
          cucumberJson.attach(JSON.stringify(prettifyBrowserLog(browserLog), null, 2), 'application/json')
      }
    }
  },

  beforeScenario: async function(world)  {
    await zephyrLibrary.zephyrBeforeScenario(world.pickle)
},

  afterScenario: async function (world, result) {
    await zephyrLibrary.zephyrAfterScenario(result)
    let logResult = ''
    if (result.passed == true) {
      logResult = 'Passed'
    } else {
      logResult = 'Failed'
    }
    console.log(logResult + " ==>> " +  " SCENARIO END ==>> :: " + world.pickle.name)
}
};
