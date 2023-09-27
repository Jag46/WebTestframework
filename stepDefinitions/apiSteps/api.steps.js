import { Given, When, Then } from "@cucumber/cucumber";
import axios from "axios";
import apiLibrary from "../../utilities/apiLibrary.js";
import {defaultConfig,encodedConfig} from "../../testData/apiRequestConfigs/requestConfigs.js";
import {makeRequest} from "../../utilities/debugContext"
import qs from "qs";
import environment from "../../support/env.js";
import apiReponseContent from "../../contents/apiResponse.content.js";
import IPCServicePayloads from "../../testData/apiPayLoads/IPCServicePayloads.js";

const fs = require("fs-extra");
const https = require("https");
let userData = require("../../utilities/globalTestData.js");
var dot = require("dot-object");

var methodType = "";
var endPointURL = "";
var requestConfig = {};

var apiResponse = {};
var apiRequestBody = {};

/********************
 * Setup Steps
 *********************/

Given(
  /^I set "(.*)" method for "(.*)"$/,
  /**
   * This step sets the HTTP request and endpoint you want to hit
   * @param {String} method Type of HTTP request (GET, PUT, POST etc.)
   * @param {String} endpoint Endpoint under test
   */
  function setMethodAndEndpoint(method, endpoint) {
    methodType = method;

    endPointURL = apiLibrary.getEndpointURL(endpoint);
  }
);

Given(
  /^I set the config for the request to "(.*)"$/,
  /**
   * This step sets the config for the HTTP request
   * @param {String} config Reference to a config case statement
   */
  function setConfig(config) {
    switch (config) {
      case "default": {
        requestConfig = defaultConfig();
        break;
      }
      case "encoded": {
        requestConfig = encodedConfig();
        break;
      }
    }
  }
);

Given(
    /^I set the query parameters for the request$/,
    /**
     * This step sets the query parameters for a HTTP request
     * @param {Object} dataTable Data table passed in the cucumber step should have a maximum of 2 columns: key, value
     */
    function setqueryParams(dataTable) {
        var tData = dataTable.raw();
        let localString = "{";
        tData.forEach(function (tRow) {
            if (tRow[1] == 'null') {
                tRow[1] = null;
            } else if (tRow[1] == 'true') {
                tRow[1] = true;
            } else if (tRow[1] == 'false') {
                tRow[1] = false;
            } else if (tRow[1] !== undefined && tRow[1].startsWith("{")) {
                var globalData = tRow[1].split('}')[0].substring(1);
                tRow[1] = userData.getField(globalData);
            } else if (tRow[1] == "global") {
              tRow[1] = userData.getField(tRow[0]);
            }
            requestConfig.params[tRow[0]] = tRow[1];
        });
    }
);

Given(
  /^I set the path paramters for a request$/,
  /**
   * This step sets the path parameters for a HTTP request (must also be statically set in apiLibrary.getEndpointURL)
   * @param {Object} dataTable Data table passed in the cucumber step should have a maximum of 2 columns: key, value
   */
  function setPathParams(dataTable) {
    apiLibrary.setPathParameters(dataTable);
  }
);

Given(
  /^I set the headers for the request$/,
  /**
   * This step sets the header parameters for a HTTP request in the request config
   * @param {Object} dataTable Data table passed in the cucumber step should have a maximum of 2 columns: key, value
   */
  function setHeaders(dataTable) {
    var tData = dataTable.raw();

    tData.forEach(function (tRow) {
      if (tRow[1] == "null") {
        tRow[1] = null;
      }
      if (tRow[1] == "true") {
        tRow[1] = true;
      }
      if (tRow[1] == "false") {
        tRow[1] = false;
      }
      if (tRow[0].toLowerCase() === "authorization") {
        const LongLiveJWT = userData.getField("jwt");
        const LongLiveJWTToken = "Bearer " + LongLiveJWT;
        tRow[1] = LongLiveJWTToken;
      }
      if (tRow[0].toLowerCase() === "location") {
        const location = userData.getField("location");
        const indexValue = location.indexOf("token") + 6;
        tRow[1] = location.substr(indexValue);
        tRow[0] = "Authorization";
      }
      if (tRow[0].toLowerCase() === "authorizationtoken") {
        const LongLiveJWT = userData.getField("jwt");
        const LongLiveJWTToken = "Bearer " + LongLiveJWT;
        tRow[1] = LongLiveJWTToken;
      }
      if (tRow[0].toLowerCase() === "x-journey-id") {
        const journeyId = userData.getField("x-journey-id");
        tRow[1] = journeyId;
      }
      requestConfig.headers[tRow[0]] = tRow[1];
    });
  }
);

Given(
  /^I prepare the "(.*)" payload details$/,
  /**
   * This step sets HTTP api request body (payload must exist in testData.apiPayLoads)
   * @param {Object} payload File name of the payload from the following location 'test/testData/apiPayLoads'
   */
  function setReqPayload(payload) {
    apiRequestBody = apiLibrary.setRequestPayload(payload);
  }
);

Given(
  /^I set the "(.*)" request body$/,
  /**
   * This step sets HTTP api request body (payload must exist in testData.apiPayLoads)
   * @param {Object} body File name of the payload from the following location 'test/testData/apiPayLoads'
   */
  function setReqBody(body) {
    switch (body.toLowerCase()) {
      //IPC Service payloads
      case "createapplication": {
        apiRequestBody = IPCServicePayloads.createapplication();
        break;
      }

      case "checkeligibility": {
        apiRequestBody = IPCServicePayloads.checkeligibility();
        break;
      }

      case "ipc_putaccountdata": {
        apiRequestBody = IPCServicePayloads.putaccountdata();
        break;
      }
      
      case "updatefatcadetails": {
        apiRequestBody = IPCServicePayloads.updatefatcadetails();
        break;
      }

      case "ipc_termsandconditionswithod": {
        apiRequestBody = IPCServicePayloads.updatetermsandconditionswithod();
        break;
      }

      case "ipc_termsandconditionswithoutod": {
        apiRequestBody = IPCServicePayloads.updatetermsandconditionswithoutod();
        break;
      }

      case "submitswitch": {
        apiRequestBody = IPCServicePayloads.submitswitch();
        break;
      }

      case "sendemailbounceback": {
        apiRequestBody = IPCServicePayloads.sendemailbounceback();
        break;
      }
    }
  }
);

Given(
  /^I set the following encoded params$/,
  /**
   * This step sets encoded values for a x-www-form-urlencoded request
   * @param {Object} dataTable Data table passed in the cucumber step should have a maximum of 2 columns: key, value
   */
  function setEncodedParams(dataTable) {
    var tData = dataTable.raw();
    tData.forEach(function (tRow) {
      if (tRow[0].toLowerCase() === "jwttoken") {
        tRow[1] = userData.getField("jwt");
        apiRequestBody[tRow[0]] = tRow[1];
      } else {
        apiRequestBody[tRow[0]] = tRow[1];
      }
    });
    apiRequestBody = qs.stringify(apiRequestBody);
  }
);

/********************
 * Call Steps
 *********************/

Given(
  /^I send the request$/,
  /**
   * This step performs the Axios request based on a number of predetermined parameters
   * set in previous setps, those include the method type, endpoint url, api request body and request config.
   * See the following steps to set those values:
   * @Step I call "(.*)" method for "(.*)"
   * @Step I set the config for the request to "(.*)"
   * @Step I prepare the "(.*)" payload details
   */
  function sendRequest() {
    var config = requestConfig;
    let endpoint = endPointURL;
    const requestBody = apiRequestBody;
    switch (methodType.toLowerCase()) {
      case "get": {
        return new Promise(function (resolve, reject) {
          const requestDetails = {
            method: 'GET',
            url: endpoint,
            ...config
          }
          makeRequest(axios, requestDetails)
            // .get(endPointURL, config)
            .then(function (response) {
              apiResponse = response;
              
              userData.setField("apiResponse", apiResponse.data);
              userData.setField("fullAPIResponse", apiResponse);
              if(response.data.responsePayload !== undefined && response.data.responsePayload !== null){
                if(response.data.responsePayload.applicantRevision !== undefined && response.data.responsePayload.applicantRevision !== null) {
                  userData.setField("applicantRevision", response.data.responsePayload.applicantRevision);
                }
                if (response.data.responsePayload.applicationRevision !== undefined && response.data.responsePayload.applicationRevision !== null){
                  userData.setField("applicationRevision",response.data.responsePayload.applicationRevision);
                }
              }
              resolve(response);
            })
            .catch(function (error) {
              apiResponse = error.response;
              if (apiResponse == null) {
                userData.setField("apiResponse", apiResponse);
              } else {
                userData.setField("apiResponse", apiResponse.data);
              }
              resolve(error);
            });
        });
      }
      case "post": {
        return new Promise(function (resolve, reject) {
          const requestDetails = {
            method: 'POST',
            url: endpoint,
            data: requestBody,
            ...config
          }
            makeRequest(axios, requestDetails)
            .then(function (response) {
              apiResponse = response;
              if (response.status === 302) {
                userData.setField("fullAPIResponse", apiResponse);
              } else if (response.status === 201) {
                userData.setField("apiResponse", response.data);
                userData.setField("fullAPIResponse", response);
                userData.setField("applicantRevision", response.data.responsePayload.applicantRevision);
                userData.setField("applicationRevision",response.data.responsePayload.applicationRevision);
                userData.setField("applicantId", response.data.responsePayload.applicantId);
              }
              resolve(response);
            })
            .catch(function (error) {
              apiResponse = error.response;
              if (apiResponse == null) {
                userData.setField("apiResponse", apiResponse);
              } else {
                userData.setField("apiResponse", apiResponse.data);
              }
              resolve(error);
            })
            .finally(function () {
              apiRequestBody = {};
            });
        });
      }
      case "put": {
        return new Promise(function (resolve, reject) {
          const requestDetails = {
            method: 'PUT',
            url: endpoint,
            data: requestBody,
            ...config
          }
            makeRequest(axios, requestDetails)
            .then(function (response) {
              apiResponse = response;
              userData.setField("apiResponse", apiResponse.data);
              userData.setField("fullAPIResponse", apiResponse);
              if (response.data.responsePayload !== undefined && response.data.responsePayload !== null){
                if(response.data.responsePayload.applicantRevision !== undefined && response.data.responsePayload.applicantRevision !== null) {
                  userData.setField("applicantRevision", response.data.responsePayload.applicantRevision);
                }
                if (response.data.responsePayload.applicationRevision !== undefined && response.data.responsePayload.applicationRevision !== null){
                  userData.setField("applicationRevision",response.data.responsePayload.applicationRevision);
                }
              }
              resolve(response);
            })
            .catch(function (error) {
              apiResponse = error.response;
              if (apiResponse == null) {
                userData.setField("apiResponse", apiResponse);
              } else {
                userData.setField("apiResponse", apiResponse.data);
              }
              resolve(error);
            })
            .finally(function () {
              apiRequestBody = {};
            });
        });
      }
    }
  }
);

/********************
 * Verification Steps
 *********************/

Given(
  /^I verify the response status code as "(.*)"$/,
  /**
   * This step validates the expected status code against the actual
   * @param {String} exceptedStatusCode Value of the expected status code
   */
  function (exceptedStatusCode) {
    //let apiResponse = userData.getField('fullAPIResponse')
    apiLibrary.verifyResponseParam(
      apiResponse.status,
      exceptedStatusCode,
      "equal"
    );
  }
);

Given(
  /^I verify the response headers$/,
  /**
   * This step validates the expected status code against the actual
   * @param {Object} dataTable Data table passed in the cucumber step should have a maximum of 3 columns: header, performAction & expectedValue
   * @param {String} header Set in the first column of the data table
   * @param {String} performAction Set in the second column of the data table
   * @param {String} expectedValue Set in the thrid column of the data table
   */
  function (dataTable) {
    var tData = dataTable.raw();

    var header = "";
    var performAction = "";
    var expectedValue = "";
    var responseStr = "";

    tData.forEach(function (tRow) {
      header = tRow[0];
      performAction = tRow[1];
      expectedValue = tRow[2];
      responseStr = userData.getField("fullAPIResponse");
      var headers = responseStr.headers;
      if (performAction.toLowerCase() == "contains") {
        var val = headers[header].includes(expectedValue);
        expect(val).to.equal(true);
        assert.exists(expectedValue, headers[header]);
      } else if (performAction.toLowerCase() == "equals") {
        expect(headers[header]).to.equal(expectedValue);
      } else if (performAction.toLowerCase() == "does not contain") {
        var val = headers[header].includes(expectedValue);
        expect(val).to.equal(false);
      } else if (performAction.toLowerCase() == "does not equal") {
        assert.notEqual(headers[header], expectedValue);
      }
    }, this);
  }
);

Given(
  /^I verify the following param value is "(.*)" with response param value$/,
  /**
   * This step validates the expected status code against the actual
   * @param {Object} dataTable Data table passed in the cucumber step should have a maximum of 2 columns: jsonPath, expectedValue
   * @param {String} performAction The type of validation to perform
   * @param {String} jsonPath See apiLibrary.getJsonPath() for more details
   */
  function (performAction, dataTable) {
    var responseStr;
    if (
      performAction.toLowerCase() == "api_equal" ||
      performAction.toLowerCase() == "api_exist" ||
      performAction.toLowerCase() == "api_null"
    ) {
      responseStr = userData.getField("apiResponse");
    }
    var tData = dataTable.raw();
    let localString = "{";
    tData.forEach(function (tRow) {
      var jsonPath = apiLibrary.getJsonPath(tRow[0]);
      var actualData = dot.pick(jsonPath, responseStr);
      var dataValue = tRow[1].startsWith("{");
      if (tRow[1] == "null") {
        tRow[1] = null;
      }
      else if (tRow[1] == "true") {
        tRow[1] = true;
      }
      else if (tRow[1] == "false") {
        tRow[1] = false;
      }
      else if (tRow[1] == "") {
        return;
      }
      else if (tRow[1] == 'currentDate') {
        var timestamp = apiLibrary.getCurrentTimeStamp();
        tRow[1] = timestamp.split("T")[0];
      }
      else if (tRow[1] !== undefined && tRow[1].startsWith(localString)) {
        var globalData = tRow[1].split("}")[0].substring(1);
        tRow[1] = userData.getField(globalData);
      }
      apiLibrary.verifyResponseParam(actualData, tRow[1], performAction);
    }, this);
  }
);

Given(
  /^I verify the number of "(.*)" returned are "(.*)" to "(.*)"$/,
  /**
   * This step validates the records returned based on interger values and asserts for various operators
   * @param {String} lookup The value to check from the api response (use json path notation)
   * @param {String} operator The type of validation to perform (equals, more than or less than)
   * @param {String} value The interger value you are expecting from the lookup param
   */
  function (lookup, operator, value) {
    var responseStr = userData.getField("apiResponse");

    const actual = dot.pick(lookup, responseStr);
    var responseLength = actual.length;

    if (operator.includes("equal")) {
      assert.equal(
        responseLength,
        parseInt(value),
        "Response Length: " +
          responseLength +
          " and expected: " +
          value +
          " are not equal values."
      );
    } else if (operator.includes("more than")) {
      assert.isAbove(responseLength, parseInt(value));
    } else if (operator.includes("less than")) {
      assert.isBelow(responseLength, parseInt(value));
    } else {
      const i = false;
      assert.isOk(i, operator + " is not a valid value for operator variable");
    }
  }
);

Given(
  /^I verify the response contains "(.*)" and equals one of$/,
  /**
   * This step validates the api response contains one of the values in the data table column
   * @param {String} value The value to check from the api response (use json path notation)
   * @param {Object} dataTable Data table passed in the cucumber step should have a maximum of 1 column: potential values
   */
  function (value, dataTable) {
    var responseStr = userData.getField("apiResponse");
    var merge = [].concat.apply([], dataTable.raw());
    var responseLength = responseStr.responsePayload.length;
    if (responseLength <= 0) {
      assert.fail(responseLength + "application were returned");
    } else {
      for (let i = 0; i < responseLength; i++) {
        let returnedValue = responseStr.responsePayload[i][value];
        assert.isOk(merge.includes(returnedValue));
      }
    }
  }
);

Given(
  /^I verify the complete response body should be "(.*)"$/,
  /**
   * This step validates the expected status code against the actual
   * @param {String} expectedResponse Value of the complete expected response
   */
  function (expectedResponse) {
    if (expectedResponse !== "skip") {
      let responseBody = JSON.stringify(apiResponse.data);
      let content = apiReponseContent[expectedResponse];

      if (content.includes("appId")) {
        content = content.replace("appIdR", userData.getField("appId"));
      }
      if (content.includes("applicantId" || "id")) {
        content = content.replace("applicantIdR", userData.getField("applicantId"));
      }
      if (content.includes("applicantRevision")) {
        content = content.replace("applicantRevisionR", userData.getField("applicantRevision"));
      }
      if (content.includes("applicationRevision")) {
        content = content.replace("applicationRevisionR",userData.getField("applicationRevision"));
      }
      if (content.includes("customerNumber")) {
        content = content.replace("customerNoR", userData.getField("customerNumber"));
      }
      if (content.includes("cisCustomerNumber")) {
        content = content.replace("customerNoR", userData.getField("customerNumber"));
      }
      if (content.includes("journeyId")) {
        content = content.replace("journeyIdR", userData.getField("x-journey-id"));
      }
      if (content.includes("lastUpdatedOn")) {
        content = content.replace("lastUpdatedTimeR", userData.getField("lastUpdatedOn"));
      }
      if (content.includes("createdOn")) {
        content = content.replace("createdTimeR", userData.getField("createdOn"));
      }
      if (content.includes("createdAt")) {
        content = content.replace("createdAtR", userData.getField("createdAt"));
      }
      if (content.includes("lastUpdatedAt")) {
        content = content.replace("lastUpdatedAtR", userData.getField("lastUpdatedAt"));
      }
      if (content.includes("customerSoftLock")) {
        content = content.replace("customerSoftLockR", userData.getField("customerSoftLock"));
      }
      if (content.includes("timestamp")) {
        content = content.replace("timestamp1", userData.getField("timestamp1"));
        content = content.replace("timestamp2", userData.getField("timestamp2"));
        content = content.replace("timestamp3", userData.getField("timestamp3"));
      }
      if(content.includes("lastName")) {
        content = content.replace("lastNameR", userData.getField("lastName"));
      }
      if(content.includes("postcode")) {
        content = content.replace("postcodeR", userData.getField("postCode"));
      }
      if (content.includes("revision")) {
        if(expectedResponse.includes("Application")) {
          content = content.replace("revisionR", userData.getField("applicationRevision"));
      }
        if(expectedResponse.includes("Applicant")) {
          content = content.replace("revisionR", userData.getField("applicantRevision"));
        }
      }
      expect(content).to.equal(responseBody);
    }
  }
);

Given(
  /^I save the response fields from "(.*)" in global data after "(.*)" to validate AppStore$/,
  /**
   * This step executes a predefined HTTP request call and sets a global value for authroization bearer token.
   * @param {String} appstore The AppStore Domain - either Application or Applicant
   * @param {String} ipcService The IPC service after which AppStore domain needs to be validated
   */
  function (appstore, ipcService) {
    var apiResponse = userData.getField("apiResponse");
    if (ipcService.includes("checkEligibility")) {
      if (appstore.includes("Application")) {
        userData.setField("timestamp1",apiResponse.responsePayload.applicationState[0].timestamp);
        userData.setField("timestamp2",apiResponse.responsePayload.applicationState[1].timestamp);
        userData.setField("timestamp3", apiResponse.responsePayload.applicationState[2].timestamp);
        userData.setField("createdOn", apiResponse.responsePayload.createdOn);
        userData.setField("lastUpdatedOn",apiResponse.responsePayload.lastUpdatedOn);
        userData.setField("applicationRevision",apiResponse.responsePayload.revision);
      }
      if (appstore.includes("Applicant")) {
        userData.setField("customerSoftLock",apiResponse.responsePayload.softLocks.customerSoftLock);
        userData.setField("createdAt", apiResponse.responsePayload.createdAt);
        userData.setField("lastUpdatedAt", apiResponse.responsePayload.lastUpdatedAt);
        userData.setField("lastName", apiResponse.responsePayload.personalInformation.name.lastName);
        userData.setField("postCode", apiResponse.responsePayload.addresses[0].postcode);
        userData.setField("lastUpdatedOn",apiResponse.responsePayload.lastUpdatedOn);
        userData.setField("applicantRevision",apiResponse.responsePayload.revision);
      }
    }
  }
);

/********************
 * Modification Steps
 *********************/

Given(
  /^I "(.*)" following param values from current request body$/,
  /**
   * This step modifys or removes the current request body based on the perfomAction
   * @param {String} performAction The type of change to perform to the payload
   * @param {Object} dataTable Data table passed in the cucumber step should have a maximum of 2 column: json path, value to change
   * @param {String} reqJsonPath See apiLibrary.getJsonPath() for more details
   */
  function (performAction, dataTable) {
    let localRequestBody = apiRequestBody;
    let tData = dataTable.raw();
    tData.forEach(function (tRow) {
      let reqJsonPath = apiLibrary.getJsonPath(tRow[0]);
      apiLibrary.requestPayloadChange(
        performAction,
        reqJsonPath,
        tRow[1],
        localRequestBody
      );
    }, this);
  }
);

Given(
  /^I prepare the "(.*)" request body template and "(.*)" following param values$/,
  /**
   * This step modifys or removes the request payload data based on the perfomAction
   * @param {Object} payload File name of the payload from the following location 'test/testData/apiPayLoads'
   * @param {String} performAction The type of change to perform to the payload
   * @param {Object} dataTable Data table passed in the cucumber step should have a maximum of 2 column: json path, value to change
   * @param {String} reqJsonPath See apiLibrary.getJsonPath() for more details
   * @param {Object} apiRequestBody Class api.steps object
   */
  function (payload, performAction, dataTable) {
    let localRequestBody = apiLibrary.setRequestPayload(payload);
    let tData = dataTable.raw();

    tData.forEach(function (tRow) {
      if (tRow[1] == "Current Date Time") {
        tRow[1] = new Date().getTime();
      }
      if (tRow[1] == "true") {
        tRow[1] = true;
      } else if (tRow[1] == "false") {
        tRow[1] = false;
      }
      let reqJsonPath = apiLibrary.getJsonPath(tRow[0]);
      apiLibrary.requestPayloadChange(performAction, reqJsonPath, tRow[1], localRequestBody);
      apiRequestBody = apiLibrary.requestPayloadChange(performAction, reqJsonPath, tRow[1], localRequestBody);
    }, this);
  }
);

Given(
  /^I save "(.*)" value from the "(.*)" future use$/,
  /**
   * This step saves response values into globalTestData.js
   * @param {String} value The value you want to save
   * @param {String} responsePart The part of the response you want to save a value from
   */
  function (value, responsePart) {
    switch (responsePart.toLowerCase()) {
      case "body": {
        var response = userData.getField("fullAPIResponse");
        var body = response.data;
        userData.setField(value, body[value]);
        break;
      }
      case "headers": {
        var response = userData.getField("fullAPIResponse");
        var headers = response.headers;
        userData.setField(value, headers[value]);
        break;
      }
    }
  }
);

Given(
  /^I "(.*)" the following global values$/,
  /**
   * This step updates global values stored in globalTestData.js
   * @param {String} performAction The value you want to save
   * @param {String} dataTable Data table passed in the cucumber step should have a maximum of 2 column: global value, value to set
   * @param {String} updatedGlobalValue See apiLibrary.requestGlobalValueChage for more details
   */
  function (performAction, dataTable) {
    var tData = dataTable.raw();
    tData.forEach(function (tRow) {
      var updatedGlobalValue = apiLibrary.requestGlobalValueChange(performAction, tRow[0], tRow[1]);
      userData.setField(tRow[0], updatedGlobalValue);
    }, this);
  }
);

Given(
  /^I modify the following param values in the current request body$/,
  /**
   * This step modifys or removes the current request body based on the perfomAction
   * @param {Object} dataTable Data table passed in the cucumber step should have a min/max of 3 column: name, value & json path
   * @param {String} tRow[0] Key of the field in the body
   * @param {String} tRow[1] The value you want set for key in the body
   * @param {String} tRow[2] Json path to the field you want to modify
   * @param {String} reqJsonPath See apiLibrary.getJsonPath() for more details
   */
  function (dataTable) {
    let localRequestBody = apiRequestBody;
    let tData = dataTable.raw();
    tData.forEach(function (tRow) {
      let reqJsonPath = apiLibrary.getJsonPath(tRow[2]);
      apiLibrary.requestPayloadChange(reqJsonPath, tRow[1], tRow[0], localRequestBody);
    }, this);
  }
);

/********************
 * E2E Steps for token generation
 *********************/

Given(
  /^I generate a JWT token for token handler exchange requests that origination from "(.*)" for this cis number "(.*)"$/,
  /**
   * This step executes a predefined HTTP request call and sets a global value of the return jwt
   * @param {String} appType The application type you want to perform (NGBA or OLB)
   * @param {String} cisNumber The CIS number you want to generate a jwt token for
   */
  function (appType, cisNumber) {
    requestConfig = defaultConfig();
    requestConfig.params["apptype"] = appType;

    return new Promise(function (resolve, reject) {
      const requestDetails = {
        method: 'GET',
        url: `${environment.getEnv("stubsBaseURL")}/generateJWTToken/${cisNumber}`,
        ...requestConfig
      }
        makeRequest(axios, requestDetails)
        .then(function (response) {
          apiResponse = response;
          userData.setField("apiResponse", apiResponse.data);
          userData.setField("fullAPIResponse", apiResponse.data);
          userData.setField("customerNumber", cisNumber);
          var body = response.data;
          userData.setField("jwt", body["jwt"]);
          resolve(response);
        })
        .catch(function (error) {
          apiResponse = error.response;
          if (apiResponse == null) {
            userData.setField("apiResponse", apiResponse);
          } else {
            userData.setField("apiResponse", apiResponse.data);
          }
          resolve();
        });
    });
  }
);

Given(
  /^I generate a token for appIdGen apptype "(.*)", productId "(.*)", new productId "(.*)", account number "(.*)" and environmnet "(.*)"$/,
  /**
   * This step executes a predefined HTTP request call and sets a global value for location header.
   * @param {String} appType The application type you want to perform (NGBA or OLB)
   * @param {String} productId The current productId you want to change
   * @param {String} newProductId The new productId you want to change to
   * @param {String} accountNumber The account number, otherwise known as SCAN (sort code & account number)
   * @param {String} environmentName The environment the request is going to be executed against
   */
  function (appType, productId, newProductId, accountNumber, environmentName) {
    endPointURL = apiLibrary.getEndpointURL("tokenHandlerExchange");
    requestConfig = encodedConfig();

    if (appType.toLowerCase() === "olb") {
      requestConfig.params["dctc"] = "210";
    } else {
      requestConfig.params["dctc"] = "216";
    }
    requestConfig.params["productid"] = productId;
    requestConfig.params["newproductid"] = newProductId;
    requestConfig.params["environmentName"] = environmentName;
    userData.setField("accountNumber", accountNumber);

    var encodedBody = {};
    encodedBody["JwtToken"] = userData.getField("jwt");
    encodedBody["accountNumber"] = accountNumber;
    encodedBody = qs.stringify(encodedBody);

    return new Promise(function (resolve, reject) {
        const requestDetails = {
          method: 'POST',
          url: endPointURL,
          data: encodedBody,
          ...requestConfig
        }
        makeRequest(axios, requestDetails)
        .then(function (response) {
          apiResponse = response;
          userData.setField("fullAPIResponse", apiResponse);
          let header = response.headers;
          userData.setField("location", header["location"]);
          resolve(response);
        })
        .catch(function (error) {
          apiResponse = error.response;
          if (apiResponse == null) {
            userData.setField("apiResponse", apiResponse);
          } else {
            userData.setField("apiResponse", apiResponse.data);
          }
          resolve(error.response);
        });
    });
  }
);

Given(
  /^I generate an authorization bearer token for apigee calls, productId "(.*)"$/,
  /**
   * This step executes a predefined HTTP request call and sets a global value for authroization bearer token.
   * @param {String} productId The current productId you are changing from, to be used as query param path
   */
  function (productId) {
    requestConfig = defaultConfig();
    requestConfig.params["productid"] = productId;
    const location = userData.getField("location");
    const indexValue = location.indexOf("token") + 6;
    requestConfig.headers["Authorization"] = location.substr(indexValue);

    endPointURL = apiLibrary.getEndpointURL("appIdGen");

    return new Promise(function (resolve, reject) {
      const requestDetails = {
        method: 'GET',
        url: endPointURL,
        ...requestConfig
      }
      makeRequest(axios, requestDetails)
        .then(function (response) {
          apiResponse = response;
          userData.setField("fullAPIResponse", apiResponse);
          let header = response.headers;
          userData.setField("authorization", header["authorization"]);
          userData.setField("appId", apiResponse.data.appId);
          resolve(response);
          let BearerAuthToken = apiLibrary.extractDecodedPayload();
          userData.setField("x-journey-id", BearerAuthToken.claimsData.journeyId);
        })
        .catch(function (error) {
          apiResponse = error.response;
          if (apiResponse == null) {
            userData.setField("apiResponse", apiResponse);
          } else {
            userData.setField("apiResponse", apiResponse.data);
          }
          resolve(error.response);
        });
    });
  }
);

Then(
  /^I call GET method for "(.*)" with required headers and send the request$/,
  /**
   * This step sets the HTTP request, endpoint, headers, endpoint url, api request body and request config for GET AppStore calls and  you want to hit
   * and performs the Axios request
   * @param {String} endpoint Endpoint under test
   */
  function setMethodAndEndpoint(endpoint) {
    endPointURL = apiLibrary.getEndpointURL(endpoint);
    const journeyId = userData.getField("x-journey-id");
    var config = requestConfig;
    config.headers["x-journey-id"] = journeyId;

    return new Promise(function (resolve, reject) {
      const requestDetails = {
        method: 'GET',
        url: endPointURL,
        ...config
      }
      makeRequest(axios, requestDetails)
        .then(function (response) {
          apiResponse = response;
          userData.setField("apiResponse", apiResponse.data);
          userData.setField("fullAPIResponse", apiResponse);
          resolve(response);
        })
        .catch(function (error) {
          apiResponse = error.response;
          if (apiResponse == null) {
            userData.setField("apiResponse", apiResponse);
          } else {
            userData.setField("apiResponse", apiResponse.data);
          }
          resolve();
        });
    });
  }
);

Then(
  /^I call POST method for CreateApplication with the headers and request body$/,
  /**
   * This step sets the HTTP request, endpoint, default config, header and hit the Create Application end point
   * @param {String} method Type of HTTP request (GET, PUT, POST etc.)
   * @param {String} endpoint Endpoint under test
   */
  
  function callEndpoint() {
    endPointURL = apiLibrary.getEndpointURL("CreateApplication");

    requestConfig = defaultConfig();
    var config = requestConfig;
    const journeyId = userData.getField("x-journey-id");
    const authorisation = userData.getField("jwt");

    config.headers["x-journey-Id"] = journeyId;
    config.headers["Authorization"] = "Bearer "+ authorisation;
    apiRequestBody = IPCServicePayloads.createapplication();

   let reqJsonPath = apiLibrary.getJsonPath("appId");
   let updatedApiRequestBody = apiLibrary.requestPayloadChange(reqJsonPath,userData.getField("appId"), "appId", apiRequestBody);

    return new Promise(function (resolve, reject) {
      const requestDetails = {
        method: 'POST',
        url: endPointURL,
        data: updatedApiRequestBody,
        ...config
      }
      makeRequest(axios, requestDetails)
        .then(function (response) {
          apiResponse = response;
          if (response.status === 201) {
            userData.setField("apiResponse", response.data);
            userData.setField("fullAPIResponse", response);
            userData.setField("applicantRevision",response.data.responsePayload.applicantRevision);
            userData.setField("applicationRevision",response.data.responsePayload.applicationRevision);
            userData.setField("applicantId",response.data.responsePayload.applicantId);
            userData.setField("appId",response.data.responsePayload.appId);
          }
          resolve(response);
        })
        .catch(function (error) {
          apiResponse = error.response;
          if (apiResponse == null) {
            userData.setField("apiResponse", apiResponse);
          } else {
            userData.setField("apiResponse", apiResponse.data);
          }
          resolve(error.response);
        })
        .finally(function () {
          apiRequestBody = {};
        });
    });
  }
);

Then(
  /^I poll the "(.*)" result$/,
  /**
   * This step sets the endpoint for an axios request and polls in until the desired response
   * @param {String} statusCall Type of HTTP request (GET, PUT, POST etc.)
   */
  
  async (statusCall) =>  {
    let endpoint = apiLibrary.getEndpointURL('IPC_ApplicationStatus');
    let config = defaultConfig()
    let statusCode
    if (statusCall.toLowerCase() == 'eligiblity status') {
      config.headers['x-journey-Id'] = userData.getField("x-journey-id")
      config.headers['Authorization'] = 'Bearer ' + userData.getField("jwt"); 
      statusCode = 'InProgress'
    } else if (statusCall == 'submit status'){
      config.headers['x-journey-Id'] = userData.getField("x-journey-id")
      config.headers['Authorization'] = 'Bearer ' + userData.getField("jwt"); 
      statusCode = 'Approved'
    }
    const requestDetails = {
      method: 'GET',
      url: endpoint,
      ...config
    }

    const statusPoll = ({ interval, maxAttempts }) => {
      console.log('Start poll...');
      let attempts = 0;
    
      const executePoll = async (resolve, reject) => {
        console.log('- poll');
        const result = await makeRequest(axios, requestDetails)
        attempts++;
    
        if (result.data.responsePayload.isEligibleForAccount !== null && (result.data.responsePayload.statusCode == statusCode || result.data.responsePayload.statusCode == 'Terminated')) {
          return resolve(result);
        } else if (maxAttempts && attempts === maxAttempts) {
          return reject(new Error('Exceeded max attempts'));
        } else {
          setTimeout(executePoll, interval, resolve, reject);
        }
      };
      return new Promise(executePoll);
    };

    const pollForStatus = statusPoll({
      interval: 500,
      maxAttempts: 20
    }).then(response => {
      apiResponse = response;
      userData.setField("apiResponse", response.data)
    }).catch(err => {console.error(err)
      apiResponse = error.response;});

    await pollForStatus

  })