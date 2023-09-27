require('@babel/register')
const { config } = require('./shared.config.js')
const { generate } = require("multiple-cucumber-html-reporter");

var today = new Date();
var date = today.toLocaleDateString("en-GB")
var startTime = today.toLocaleTimeString('en-GB') + today.getSeconds()

exports.config = {
    ...config,

    serverUrls: {
        environment: 'dev4'
    },
    path: '/wd/hub',

    specs: ['test/features/GUI/1_IntroPage/startIPCJourney.feature'],
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
    maxInstances: 1,

    capabilities: [
      {
        browserName: 'chrome',
        'goog:chromeOptions': {
          excludeSwitches: [ "enable-automation" ],
          args: [
            // '--headless',
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
        browserVersion: 'latest',
        acceptInsecureCerts: true,
        "cjson:metadata": {
          browser: {
            name: 'chrome',
            version: 'latest'
          },
          device: "docker",
          platform: {
            name: "Linux",
            version: "latest"
          }
        }
      }
        // firefox version.  Need to adjust docker services to read firefox instead of chrome
        // ,{
        //   browserName: 'firefox',
        //   'moz:firefoxOptions': {
        //     args: [
        //       '-headless'
        //     ]
        //   },
        //   platformName: 'Linux',
        //   acceptInsecureCerts: true,
        //   "cjson:metadata": {
        //     browser: {
        //       name: 'firefox',
        //       version: 'latest'
        //     },
        //     device: "docker",
        //     platform: {
        //       name: "linux",
        //       version: "latest"
        //     }
        //   }
        // }
    ],

    // ===================
    // Test Configurations
    // ===================
    // Define all options that are relevant for the WebdriverIO instance here

    // Services take over a specific job you don't want to take care of. They enhance
    // your test setup with almost no effort. Unlike plugins, they don't add new
    // commands. Instead, they hook themselves up into the test process.

    services: ['docker'],
    dockerLogs: './test/reports',
    dockerOptions: {
        image: 'selenium/standalone-chrome-debug',
        healthCheck: {
          url: 'http://localhost:4444',
          startDelay: 2000
        },
        options: {
            p: ['4444:4444', '5900:5900'],
            addHost: ['dockerhost:192.168.1.101'],
            name: 'sao-test-selenium-chrome',
            shmSize: '2g'
        }
    },

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
        var executionEndTime =
            endTime.getDate() +
            '-' +
            (endTime.getMonth() + 1) +
            '-' +
            endTime.getFullYear() +
            ' ' +
            endTime.getHours() +
            ':' +
            endTime.getMinutes() +
            ':' +
            endTime.getSeconds();
        var duration = endTime - today;
        var hh = Math.floor(duration / 1000 / 60 / 60);
        duration -= hh * 1000 * 60 * 60;
        var mm = Math.floor(duration / 1000 / 60);
        duration -= mm * 1000 * 60;
        var ss = Math.floor(duration / 1000);
        duration -= ss * 1000;
        duration = hh + ':' + mm + ':' + ss;

        generate({
            // Required
            // This part needs to be the same path where you store the JSON files
            // default = '.tmp/json/'
            //for more options see https://github.com/wswebcreation/multiple-cucumber-html-reporter#options
            jsonDir: 'test/reports/',
            reportPath: 'test/reports/',
            displayDuration: true,
            customMetadata: false,
            pageFooter:
                '<div><p style=text-align:center;>Generic framework</p></div>',
            reportName:
                '<h2><div><p style=text-align:center;>Generic Framework - Functional Automation Test Report</p></div><h2>',

            customData: {
                title: 'Execution Summary Details',
                data: [
                    { label: 'Project', value: 'Your Project' },
                    { label: 'Release', value: 'Your Release' },
                    {label: 'Execution Start Time', value: date + ' ' + startTime},
                    { label: 'Execution End Time', value: executionEndTime },
                    { label: 'Execution Duration Time', value: duration }
                ]
            }
        });
    }
};
