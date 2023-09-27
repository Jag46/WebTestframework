require('@babel/register')
const { config } = require('./shared.config.js')
const { generate } = require("multiple-cucumber-html-reporter");

var today = new Date();
var date = today.toLocaleDateString("en-GB")
var startTime = today.toLocaleTimeString('en-GB') + today.getSeconds()

var testTags = process.env.testTags || 'not (@manual or @skip or @defect)'
var selenoidSessionName = 'IPC-' + testTags + '_#' + (process.env.BUILD_NUMBER || 'local')
const selenoidSessionTimeout = ((process.env.DEBUG ? 60 * 60 * 500 : 30000 + 300) / 1000).toString() + 's'

exports.config = {
  ...config,

  serverUrls: {
    environment: process.env.testEnvironment || 'dev4'
  },

  specs: [
    process.env.testSpecs
    || "test/features/API/3.IPC_Service/GetAccountList.feature"
  ],
  // Patterns to exclude.
  exclude: [
    // 'path/to/excluded/files'
  ],
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
  maxInstances: process.env.maxInstances || 5,

  capabilities: [
    {
      browserName: "chrome",
      acceptInsecureCerts: true,
      "goog:chromeOptions": {
        excludeSwitches: [ "enable-automation" ],
        "args" : [
          //'--headless',
          '--disable-plugins', '--no-sandbox', '--start-maximized',
          '--use-fake-ui-for-media-stream', '--use-fake-device-for-media-stream',
          '--disable-web-security', '--disable-prompt-on-repost',
          '--allow-http-background-page',
          '--allow-running-insecure-content',
          '--allow-insecure-localhost'
        ]
        ,
        prefs: {
          "profile.default_content_setting_values.media_stream_camera": 1
          }
      },
      'selenoid:options': { 
        enableVNC: true, enableVideo: true, limit: 5,
        env: ["LANG=en_GB.UTF-8", "LANGUAGE=en", "LC_ALL=en_GB.UTF-8"],
        labels: {"environment": "IPC", "build-number": selenoidSessionName},
        name: selenoidSessionName,
        sessionTimeout: selenoidSessionTimeout
      },
      "cjson:metadata": {
        browser: {
          name: "chrome",
          version: "latest"
        },
        device: "Selenoid",
        platform: {
          name: "Linux",
          version: "Kali"
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
  hostname: 'selenoid-cco-int.banking.ops-x.ops.agile.nationwide.co.uk',
  path: "/wd/hub",
  port: 80,
  acceptInsecureCerts: true,
  rejectUnauthorized: false,
  // Services take over a specific job you don't want to take care of. They enhance
  // your test setup with almost no effort. Unlike plugins, they don't add new
  // commands. Instead, they hook themselves up into the test process.

  services: ['intercept'],

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
  onComplete: () => {
    // Generate the report when it all tests are done
    var endTime = new Date();
    var executionEndTime = endTime.getDate() + "/" + (endTime.getMonth() + 1) + "/" + endTime.getFullYear() + " " + endTime.getHours() + ":" + endTime.getMinutes() + ":" + endTime.getSeconds();
    var duration = endTime - today;
    var hh = Math.floor(duration / 1000 / 60 / 60);
    duration -= hh * 1000 * 60 * 60;
    var mm = Math.floor(duration / 1000 / 60);
    duration -= mm * 1000 * 60;
    var ss = Math.floor(duration / 1000);
    duration -= ss * 1000;
    duration = hh + ":" + mm + ":" + ss;

    generate({
      // Required
      // This part needs to be the same path where you store the JSON files
      // default = '.tmp/json/'
      //for more options see https://github.com/wswebcreation/multiple-cucumber-html-reporter#options
      jsonDir: "test/reports/",
      reportPath: "test/reports/",
      displayDuration: true,
      customMetadata: false,
      pageFooter: "<div><p style=text-align:center;>Generic framework</p></div>",
      reportName: "<h2><div><p style=text-align:center;>Generic Framework - Functional Automation Test Report</p></div><h2>",

      customData: {
        title: "Execution Summary Details",
        data: [
          { label: "Project", value: "Your Project" },
          { label: "Release", value: "Your Release" },
          { label: "Execution Start Time", value: date + " " + startTime },
          { label: "Execution End Time", value: executionEndTime },
          { label: "Execution Duration Time", value: duration },
        ]
      }
    });
  }
};
