import axios from 'axios';
import { defaultConfig } from '../../testData/apiRequestConfigs/requestConfigs.js';
import { testScriptBody, testCaseBody, updatedTestCaseBody, testCycleBody, testCycleIssueBody, testCycleWebLinkBody, testExecutionBody, updatedTestCaseFolderBody } from '../../zephyrData/zephyrPayloads.js';
import qs from 'qs';
import { request } from 'http';

const fs = require('fs-extra');
const https = require('https');
let zephyrData = require('./zephyrData.js');

var endPointURL = '';
var requestConfig = {};
var apiResponse = {};

var zephyrAuthorization = process.env.ZEPHYR_KEY || "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI2Mzc2ZDkwMi1mYmI2LTM5NzMtODY4NC1kNjgyM2VkMDYxMjEiLCJjb250ZXh0Ijp7ImJhc2VVcmwiOiJodHRwczpcL1wvbmF0aW9ud2lkZS11ay5hdGxhc3NpYW4ubmV0IiwidXNlciI6eyJhY2NvdW50SWQiOiI1Y2MyZDk2M2UyYzQzOTBmMDRkMzE4ZTYifX0sImlzcyI6ImNvbS5rYW5vYWgudGVzdC1tYW5hZ2VyIiwiZXhwIjoxNjUxNjUyNjMwLCJpYXQiOjE2MjAxMTY2MzB9.StQ6o-Zn17N6wecGAjkP3mqBSxmF1vNKx0MURleVW4c"

class zephyrRequests {

    //Calls a zephyr endpoint to get a test case based on a test key, if it finds one it sets the testCaseStatus and testCaseName globally
    //if the call returns an error it sets that in testCaseMessage globally.
    zephyrGetTestCase(testKey) {
        endPointURL = 'https://api.tm4j.smartbear.com/rest-api/v2/testcases/'+testKey
        requestConfig = defaultConfig()
        requestConfig.headers['Authorization'] = zephyrAuthorization
        return new Promise(function (resolve, reject) {
            axios
                .get(endPointURL, requestConfig)
                .then(function (response) {
                    apiResponse = response;
                    zephyrData.setField('testCaseStatus', apiResponse.status)
                    zephyrData.setField('testCaseName', apiResponse.data.name)
                    zephyrData.setField('testCaseId', apiResponse.data.id)
                    zephyrData.setField('testProjectId', apiResponse.data.project.id)
                    zephyrData.setField('testLabels', apiResponse.data.labels)
                    zephyrData.setField('testFolder', apiResponse.data.folder)
                    resolve(response);
                })
                .catch(function (error) {
                    apiResponse = error.response;
                    const {config:{url}, config:{headers}, response:{data}} = error
                    console.error(url)
                    console.error(headers)
                    console.error(data)
                    zephyrData.setField('testCaseMessage', apiResponse.data.message)
                    resolve(error);
                })
        });
    }

    //Calls a zephyr endpoint to check if a test case has an associated test script
    zephyrGetTestScript(testKey) {
        endPointURL = 'https://api.tm4j.smartbear.com/rest-api/v2/testcases/'+testKey+'/testscript'
        requestConfig = defaultConfig()
        requestConfig.headers['Authorization'] = zephyrAuthorization
        return new Promise(function (resolve, reject) {
            axios
                .get(endPointURL, requestConfig)
                .then(function (response) {
                    apiResponse = response;
                    zephyrData.setField('testScriptStatus', apiResponse.status)
                    resolve(response);
                })
                .catch(function (error) {
                    apiResponse = error.response;
                    const {config:{url}, config:{headers}, response:{data}} = error
                    console.error(url)
                    console.error(headers)
                    console.error(data)
                    zephyrData.setField('testScriptStatus', apiResponse.status)
                    resolve();
                })
        });
    }

    //Calls a zephyr endpoint to check if a test case has assoicated test steps
    //And saves the first instance of a test step to a global value
    zephyrGetTestSteps(testKey) {
        endPointURL = 'https://api.tm4j.smartbear.com/rest-api/v2/testcases/'+testKey+'/teststeps'
        requestConfig = defaultConfig()
        requestConfig.params['maxResults'] = 500
        requestConfig.headers['Authorization'] = zephyrAuthorization
        return new Promise(function (resolve, reject) {
            axios
                .get(endPointURL, requestConfig)
                .then(function (response) {
                    apiResponse = response;
                    zephyrData.setField('testStepsStatus', apiResponse.status)
                    zephyrData.setField('firstTestStep', apiResponse.data.values[0])
                    zephyrData.setField('allTestSteps', apiResponse.data.values)
                    zephyrData.setField('zephyrTotalStepCount', apiResponse.data.values.length)
                    resolve(response);
                })
                .catch(function (error) {
                    apiResponse = error.response;
                    const {config:{url}, config:{headers}, response:{data}} = error
                    console.error(url)
                    console.error(headers)
                    console.error(data)
                    zephyrData.setField('testStepsStatus', apiResponse.status)
                    resolve();
                })
        });
    }

    zephyrCreateTestCase(name, labels) {
        let createTestCaseBody = testCaseBody(name,labels)
        endPointURL = 'https://api.tm4j.smartbear.com/rest-api/v2/testcases'
        requestConfig = defaultConfig()
        requestConfig.headers['Authorization'] = zephyrAuthorization
        return new Promise(function (resolve, reject) {
            axios
                .post(endPointURL, createTestCaseBody, requestConfig)
                .then(function (response) {
                    apiResponse = response;
                    zephyrData.setField('createTestStatus', apiResponse.status)
                    zephyrData.setField('testCaseKey', apiResponse.data.key)
                    resolve(response);
                })
                .catch(function (error) {
                    apiResponse = error.response;
                    const {config:{url}, config:{headers}, response:{data}} = error
                    console.error(url)
                    console.error(headers)
                    console.error(data)
                    zephyrData.setField('createTestStatus', apiResponse.status)
                    resolve();
                })
        });
    }

    zephyrUpdateTestCase(testKey, id, name, project, labels) {
        let updateTestCaseBody = updatedTestCaseBody(id,testKey,name,project,labels)
        endPointURL = 'https://api.tm4j.smartbear.com/rest-api/v2/testcases/'+ testKey
        requestConfig = defaultConfig()
        requestConfig.headers['Authorization'] = zephyrAuthorization
        return new Promise(function (resolve, reject) {
            axios
                .put(endPointURL, updateTestCaseBody, requestConfig)
                .then(function (response) {
                    apiResponse = response;
                    zephyrData.setField('updatedTestCaseStatus', apiResponse.status)
                    resolve(response);
                })
                .catch(function (error) {
                    apiResponse = error.response;
                    const {config:{url}, config:{headers}, response:{data}} = error
                    console.error(url)
                    console.error(headers)
                    console.error(data)
                    zephyrData.setField('updatedTestCaseStatus', apiResponse.status)
                    resolve();
                })
        });
    }

    zephyrUpdateTestCaseFolder(testKey, id, name, project, folder) {
        let updateTestCaseBody = updatedTestCaseFolderBody(id,testKey,name,project,folder)
        endPointURL = 'https://api.tm4j.smartbear.com/rest-api/v2/testcases/'+ testKey
        requestConfig = defaultConfig()
        requestConfig.headers['Authorization'] = zephyrAuthorization
        return new Promise(function (resolve, reject) {
            axios
                .put(endPointURL, updateTestCaseBody, requestConfig)
                .then(function (response) {
                    apiResponse = response;
                    zephyrData.setField('updatedTestCaseStatus', apiResponse.status)
                    resolve(response);
                })
                .catch(function (error) {
                    apiResponse = error.response;
                    const {config:{url}, config:{headers}, response:{data}} = error
                    console.error(url)
                    console.error(headers)
                    console.error(data)
                    zephyrData.setField('updatedTestCaseStatus', apiResponse.status)
                    resolve();
                })
        });
    }

    zephyrAddTestScript(testKey,testSteps) {
        let addTestScriptBody = testScriptBody(testSteps)
        endPointURL = 'https://api.tm4j.smartbear.com/rest-api/v2/testcases/' + testKey + '/testscript'
        requestConfig = defaultConfig()
        requestConfig.headers['Authorization'] = zephyrAuthorization
        return new Promise(function (resolve, reject) {
            axios
                .post(endPointURL, addTestScriptBody, requestConfig)
                .then(function (response) {
                    apiResponse = response;
                    zephyrData.setField('createTestScriptStatus', apiResponse.status)
                    resolve(response);
                })
                .catch(function (error) {
                    apiResponse = error.response;
                    const {config:{url}, config:{headers}, response:{data}} = error
                    console.error(url)
                    console.error(headers)
                    console.error(data)
                    zephyrData.setField('createTestScriptStatus', apiResponse.status)
                    resolve();
                })
        });
    }

    zephyrAddTestSteps(testKey, testStepBody) {
        endPointURL = 'https://api.tm4j.smartbear.com/rest-api/v2/testcases/' + testKey + '/teststeps'
        requestConfig = defaultConfig()
        requestConfig.headers['Authorization'] = zephyrAuthorization
        return new Promise(function (resolve, reject) {
            axios
                .post(endPointURL, testStepBody, requestConfig)
                .then(function (response) {
                    apiResponse = response;
                    zephyrData.setField('createTestStepsStatus', apiResponse.status)
                    resolve(response);
                })
                .catch(function (error) {
                    apiResponse = error.response;
                    const {config:{url}, config:{headers}, response:{data}} = error
                    console.error(url)
                    console.error(headers)
                    console.error(data)
                    zephyrData.setField('createTestStepsStatus', apiResponse.status)
                    resolve();
                })
        });
    }

    zephyrGetTestCycles() {
        endPointURL = 'https://api.tm4j.smartbear.com/rest-api/v2/testcycles'
        requestConfig = defaultConfig()
        requestConfig.params['maxResults'] = 2000
        requestConfig.params['projectKey'] = 'CAO'
        requestConfig.headers['Authorization'] = zephyrAuthorization
        return new Promise(function (resolve, reject) {
            axios
                .get(endPointURL, requestConfig)
                .then(function (response) {
                    apiResponse = response;
                    zephyrData.setField('getTestCyclesStatus', apiResponse.status)
                    zephyrData.setField('getTestCyclesValues', apiResponse.data.values)
                    zephyrData.setField('getTestCyclesTotal', apiResponse.data.total)
                    resolve(response);
                })
                .catch(function (error) {
                    apiResponse = error.response;
                    const {config:{url}, config:{headers}, response:{data}} = error
                    console.error(url)
                    console.error(headers)
                    console.error(data)
                    zephyrData.setField('getTestCyclesStatus', apiResponse.status)
                    resolve();
                })
        });
    }

    zephyrGetTestCycle(cycleKey) {
        endPointURL = 'https://api.tm4j.smartbear.com/rest-api/v2/testcycles/'+ cycleKey
        requestConfig = defaultConfig()
        requestConfig.headers['Authorization'] = zephyrAuthorization
        return new Promise(function (resolve, reject) {
            axios
                .get(endPointURL, requestConfig)
                .then(function (response) {
                    apiResponse = response;
                    zephyrData.setField('getTestCycleStatus', apiResponse.status)
                    zephyrData.setField('getTestCycleKey', apiResponse.data.key)
                    resolve(response);
                })
                .catch(function (error) {
                    apiResponse = error.response;
                    const {config:{url}, config:{headers}, response:{data}} = error
                    console.error(url)
                    console.error(headers)
                    console.error(data)
                    zephyrData.setField('getTestCycleStatus', apiResponse.status)
                    resolve();
                })
        });
    }

    zephyrCreateTestCycle(cycleName) {
        let createTestCycleBody = testCycleBody(cycleName)
        endPointURL = 'https://api.tm4j.smartbear.com/rest-api/v2/testcycles'
        requestConfig = defaultConfig()
        requestConfig.headers['Authorization'] = zephyrAuthorization
        return new Promise(function (resolve, reject) {
            axios
                .post(endPointURL, createTestCycleBody ,requestConfig)
                .then(function (response) {
                    apiResponse = response;
                    zephyrData.setField('createTestCycleStatus', apiResponse.status)
                    zephyrData.setField('createTestCycleId', apiResponse.data.id)
                    resolve(response);
                })
                .catch(function (error) {
                    apiResponse = error.response;
                    const {config:{url}, config:{headers}, response:{data}} = error
                    console.error(url)
                    console.error(headers)
                    console.error(data)
                    zephyrData.setField('createTestCycleStatus', apiResponse.status)
                    resolve();
                })
        });
    }

    zephyrLinkTestCycleIssue(cycleId, issueLink) {
        let linkTestCycleIssueBody = testCycleIssueBody(issueLink)
        endPointURL = 'https://api.tm4j.smartbear.com/rest-api/v2/testcycles/' + cycleId + '/links/issues'
        requestConfig = defaultConfig()
        requestConfig.headers['Authorization'] = zephyrAuthorization
        return new Promise(function (resolve, reject) {
            axios
                .post(endPointURL, linkTestCycleIssueBody ,requestConfig)
                .then(function (response) {
                    apiResponse = response;
                    zephyrData.setField('linkTestCycleStatus', apiResponse.status)
                    resolve(response);
                })
                .catch(function (error) {
                    apiResponse = error.response;
                    const {config:{url}, config:{headers}, response:{data}} = error
                    console.error(url)
                    console.error(headers)
                    console.error(data)
                    zephyrData.setField('createTestCycleStatus', apiResponse.status)
                    resolve();
                })
        });
    }

    zephyrGetCycleWebLinks(cycleId) {
        endPointURL = 'https://api.tm4j.smartbear.com/rest-api/v2/testcycles/' + cycleId + '/links'
        requestConfig = defaultConfig()
        requestConfig.headers['Authorization'] = zephyrAuthorization
        return new Promise(function (resolve, reject) {
            axios
                .get(endPointURL, requestConfig)
                .then(function (response) {
                    apiResponse = response;
                    zephyrData.setField('getCycleWebLinksStatus', apiResponse.status)
                    zephyrData.setField('cycleWebLinks', apiResponse.data.webLinks)
                    resolve(response);
                })
                .catch(function (error) {
                    apiResponse = error.response;
                    const {config:{url}, config:{headers}, response:{data}} = error
                    console.error(url)
                    console.error(headers)
                    console.error(data)
                    zephyrData.setField('getCycleWebLinksStatus', apiResponse.status)
                    resolve();
                })
        });
    }

    zephyrLinkTestWebLink(cycleId, issueLink) {
        let linkTestCycleIssueBody = testCycleWebLinkBody(issueLink)
        endPointURL = 'https://api.tm4j.smartbear.com/rest-api/v2/testcycles/' + cycleId + '/links/weblinks'
        requestConfig = defaultConfig()
        requestConfig.headers['Authorization'] = zephyrAuthorization
        return new Promise(function (resolve, reject) {
            axios
                .post(endPointURL, linkTestCycleIssueBody ,requestConfig)
                .then(function (response) {
                    apiResponse = response;
                    zephyrData.setField('linkTestCycleStatus', apiResponse.status)
                    resolve(response);
                })
                .catch(function (error) {
                    apiResponse = error.response;
                    const {config:{url}, config:{headers}, response:{data}} = error
                    console.error(url)
                    console.error(headers)
                    console.error(data)
                    zephyrData.setField('createTestCycleStatus', apiResponse.status)
                    resolve();
                })
        });
    }

    zephyrCreateTestExecution(testCaseKey, testCycleKey, status, stepResultArray) {
        let createTestExecutionBody = testExecutionBody(testCaseKey, testCycleKey, status, stepResultArray)
        endPointURL = 'https://api.tm4j.smartbear.com/rest-api/v2/testexecutions'
        requestConfig = defaultConfig()
        requestConfig.headers['Authorization'] = zephyrAuthorization
        return new Promise(function (resolve, reject) {
            axios
                .post(endPointURL, createTestExecutionBody ,requestConfig)
                .then(function (response) {
                    apiResponse = response;
                    console.log(response)
                    zephyrData.setField('createTestExecutionStatus', apiResponse.status)
                    resolve(response);
                })
                .catch(function (error) {
                    apiResponse = error.response;
                    const {config:{url}, config:{headers}, response:{data}} = error
                    console.error(url)
                    console.error(headers)
                    console.error(data)
                    zephyrData.setField('createTestExecutionStatus', apiResponse.status)
                    resolve();
                })
        });
    }
}
export default new zephyrRequests();