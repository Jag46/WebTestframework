require('@babel/register')
const { config } = require('../shared.config.js')
const { generate } = require("multiple-cucumber-html-reporter");
var browserstack = require('browserstack-local');


var today = new Date();
var date = today.toLocaleDateString("en-GB")
var startTime = today.toLocaleTimeString('en-GB')+ today.getSeconds()

exports.config = {
  ...config,

  deviceUnderTest: 'win7',

  serverUrls: {
    environment: process.env.testEnvironment || "dev4"
  },

  specs: [process.env.testSpecs || 'test/features/gui/2.aboutYouPage/aboutYouPage.feature'],

  //
  // ============
  // Capabilities
  // ============
  // Define your capabilities here. WebdriverIO can run multiple capabilities at the same
  // time. Depending on the number of capabilities, WebdriverIO launches several test
  // sessions. Within your capabilities you can overwrite the spec and exclude options in
  // order to group specific specs to a specific capability.
  //
  // First, you can define how many instances should be started at the same time. Let's
  // say you have 3 different capabilities (Chrome, Firefox, and Safari) and you have
  // set maxInstances to 1; wdio will spawn 3 processes. Therefore, if you have 10 spec
  // files and you set maxInstances to 10, all spec files will get tested at the same time
  // and 30 processes will get spawned. The property handles how many capabilities
  // from the same test should run tests.
  //
  maxInstances: 2,
  // maxInstancesPerCapability: 5,

  commonCapabilities: {
    'bstack:options': {
      "os": "Windows",
      "osVersion": "7",
      "acceptInsecureCerts": true,
      "seleniumVersion": "3.141.59",
      "local": "true",
      "projectName": "IPC",
      "buildName": "Windows 7 - Windows Compatibility",
      "sessionName": "IPC Windows 7 OS Compatibility - " + date + ", " + startTime,
      "debug": "true",
      "consoleLogs": "verbose",
      "networkLogs": "true",
      "idleTimeout": 90
    },
  },

  capabilities: [
    {
      "browserName": "Chrome",
      "browserVersion": "latest",
      "cjson:metadata": {
        browser: {
          name: "chrome",
          version: "latest"
        },
        device: "Win 7",
        platform: {
          name: "Windows",
          version: "7"
        }
      }
    },
    {
      "browserName": "Chrome",
      "browserVersion": "latest-1",
      "cjson:metadata": {
        browser: {
          name: "chrome",
          version: "latest-1"
        },
        device: "Win 7",
        platform: {
          name: "Windows",
          version: "7"
        }
      }
    }
  ],

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

  //host: 'hub.browserstack.com',
  path: "/wd/hub",

  // Services take over a specific job you don't want to take care of. They enhance
  // your test setup with almost no effort. Unlike plugins, they don't add new
  // commands. Instead, they hook themselves up into the test process.

  //services: ['selenium-standalone', 'phantomjs', 'appium'],
  services: [
     ['browserstack', {
        browserstackLocal: true,
        forcedStop: true
    }],['intercept']
],
user: process.env.BROWSERSTACK_USER_NAME || '',
key: process.env.BROWSERSTACK_KEY || '',

  //
  // =====
  // Hooks
  // =====
  // WedriverIO provides several hooks you can use to interfere with the test process in order to enhance
  // it and to build services around it. You can either apply a single function or an array of
  // methods to it. If one of them returns with a promise, WebdriverIO will wait until that promise got
  // resolved to continue.

  /**
   * Gets executed after all workers got shut down and the process is about to exit.
   */
  onComplete: function() {
    // Generate the report when it all tests are done
    var endTime = new Date()
    var executionEndTime = endTime.toLocaleString('en-GB')
    var duration = endTime - today
    var hh = Math.floor(duration / 1000 / 60 / 60)
    duration -= hh * 1000 * 60 * 60
    var mm = Math.floor(duration / 1000 / 60)
    duration -= mm * 1000 * 60
    var ss = Math.floor(duration / 1000)
    duration -= ss * 1000
    duration = hh + ":" + mm + ":" + ss

    var reportName
    if (typeof process.env.testSpecs !== 'undefined') {
        if (process.env.testSpecs.includes("apigee")) {
        reportName = "APIGEE"
      } else if (process.env.testSpecs.includes("API")) {
        reportName = "API"
      } else if (process.env.testSpecs.includes("GUI")) {
        reportName = "UI"
      } else {
        reportName = "API and UI Functional"
      }
    } else {
      reportName = "browserStack ran locally"
    }

    generate({
      // Required
      // This part needs to be the same path where you store the JSON files
      // default = '.tmp/json/'
      //for more options see https://github.com/wswebcreation/multiple-cucumber-html-reporter#options
      jsonDir: "test/reports/",
      reportPath: "test/reports/",
      displayDuration: true,
      //openReportInBrowser: true,
      customMetadata: false,
      pageFooter: "<div><p style=text-align:center;> Savings Account Originations</p></div>",
      reportName: "<h2><div><p style=text-align:center;>Savings Account Originations - " + reportName + " Automation Test Report</p></div><h2>",

      customData: {
        title: "Execution Summary Details",
        data: [
          { label: "Project", value: "Savings Account Originations" },
          { label: "Release", value: "MVP V1.0.0" },
          { label: "Environment", value: process.env.testEnvironment },
          { label: "Feature File Specs", value: process.env.testSpecs },
          { label: "tag Expression", value: process.env.testTags },
          { label: "Execution Start Time", value: date + " " + startTime },
          { label: "Execution End Time", value: executionEndTime },
          { label: "Execution Duration Time", value: duration },

        ]
      }
    })
  }
},

//Code to support common capabilities
exports.config.capabilities.forEach(function (caps) {
  for (var i in exports.config.commonCapabilities) caps[i] = caps[i] || exports.config.commonCapabilities[i]
})