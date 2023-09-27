import userData from './globalTestData.js';
import requestApiConfig from '../config/apiRequest.config.js';
import responseApiConfig from '../config/apiResponse.config';
import environment from '../support/env.js';
var dot = require('dot-object');
const fs = require("fs-extra");

class apiLibrary {

/**
 * This method returns a full api url based on the referenceName
 * @param {String} refrenceName Name of the api endpoint you want to target
 */
    getEndpointURL(refrenceName) {
        var endpointUrl;
        /* Webapp URLS */
        if (refrenceName == 'ipcHandoff') {
            endpointUrl = environment.getEnv('ipcHandoff');
        } 

        /* Stub URLS */
        else if (refrenceName == 'generateJWT') {
            endpointUrl = environment.getEnv('stubsBaseURL') + '/generateJWTToken/' + userData.getField('cisnumber');
        } 

        /* Eligibility */
        else if (refrenceName == 'eligibility') {
            endpointUrl = environment.getEnv('eligibility') + '/api/v2/eligible/IPCEligibility';
        } 

        /* Get Account Locks */
        else if (refrenceName == 'accountLocks') {
            endpointUrl = environment.getEnv('accountManager') + '/account-setup/v1/Account/GetAccountLocks';
        } 

        /* Get Account Locks */
        else if (refrenceName == 'accountDetails') {
            endpointUrl = environment.getEnv('accountManager') + '/account-setup/v1/retrieveaccountdetails';
        } 

        /* IPC Service-Get Account List */
        else if (refrenceName == 'IPC_AccountList') {
            endpointUrl = environment.getEnv('IPCService') + '/ipcservice/api/v1/applications/'+ userData.getField('appId') + '/accountlist';
        } 

        /* IPC Service - Check Eligibility */
        else if (refrenceName == 'CheckEligibility') {
            endpointUrl = environment.getEnv('IPCService') + '/ipcservice/api/v1/applications/' + userData.getField('appId') + '/eligibility';
        } 

         /* IPC Service - Create Application */
         else if (refrenceName == 'CreateApplication') {
            endpointUrl = environment.getEnv('IPCService') + '/ipcservice/api/v1/applications';
        } 

        /* IPC Service - Perform Switch */
        else if (refrenceName == 'IPC_PerformSwitch') {
            endpointUrl = environment.getEnv('IPCService') + '/ipcservice/api/v1/applications/' + userData.getField('appId') +'/submit';
        } 

        /* IPC Service - Get/Update customer details */
        else if (refrenceName == 'GetCustomerDetails') {
            endpointUrl = environment.getEnv('IPCService') + '/ipcservice/api/v1/applications/'+ userData.getField('appId') +'/customer';
        } 

        /* IPC Service - Get application status after eligibility */
        else if (refrenceName == 'IPC_ApplicationStatus') {
            endpointUrl = environment.getEnv('IPCService') + '/ipcservice/api/v1/applications/' + userData.getField('appId') +'/status';
        } 

        /* IPC Service - Update customer FATCA details */
        else if (refrenceName == 'IPC_FATCADetails') {
            endpointUrl = environment.getEnv('IPCService') + '/ipcservice/api/v1/applications/' + userData.getField('appId') +'/customer/fatca';
        } 

         /* IPC Service - Get Product data */
         else if (refrenceName == 'GetProductData') {
            endpointUrl = environment.getEnv('IPCService') + '/ipcservice/api/v1/applications/'+ userData.getField('appId') + '/product';
        } 

        /* IPC Service - Update Account data to the AppStore */
        else if (refrenceName == 'IPC_AccountData') {
            endpointUrl = environment.getEnv('IPCService') + '/ipcservice/api/v1/applications/' + userData.getField('appId') + '/customer' + '/account';
        } 

         /* IPC Service - Update Terms and Conditions */
         else if (refrenceName == 'IPC_TermsAndConditions') {
            endpointUrl = environment.getEnv('IPCService') + '/ipcservice/api/v1/applications/' + userData.getField('appId') +'/termsandconditions';
        }
        
        /* IPC Service - SendEmailBounceback*/
        else if (refrenceName == 'IPC_SendEmailBounceback') {
            endpointUrl = environment.getEnv('IPCService') + '/ipcservice/api/v1/applications/' + userData.getField('appId') +'/SendEmailBounceback';
        }

        /* IPC Service - SendESignatureDocs*/
        else if (refrenceName == 'IPC_SendESignatureDocs') {
            endpointUrl = environment.getEnv('IPCService') + '/ipcservice/api/v1/applications/' + userData.getField('appId') +'/SendESignatureDocs';
        } 

        /* AppStore Service - Get Application */
        else if (refrenceName == 'RAS_GetApplication') {
            endpointUrl = environment.getEnv('appStoreServiceApplication') + '/api/v1/applications/' + userData.getField('appId');
        } 

        /* AppStore Service - Get Applicant */
        else if (refrenceName == 'RAS_GetApplicant') {
            endpointUrl = environment.getEnv('appStoreServiceApplicant') + '/api/v1/applicants/' + userData.getField('applicantId');
        }

        /* APIGEE URLS */
        else if (refrenceName == 'tokenHandlerExchange') {
            endpointUrl = environment.getEnv('apigeeBaseURL') + '/banking/originations/v1/tokenhandler/exchange'
        } else if (refrenceName == 'appIdGen') {
            endpointUrl = environment.getEnv('apigeeBaseURL') + '/cao-dev4/idgenerator/v2/appids/new'
        } else if (refrenceName == 'validateToken') {
            endpointUrl = environment.getEnv('apigeeBaseURL') + '/cao-dev4/v1/tokenhandler/validate'
        } 
        
        /* Misc URLs */
        else {
            endpointUrl = refrenceName;
        }
        console.log('Service: '+refrenceName + '. --- End point: ' + endpointUrl);
        return endpointUrl;
    }

/**
 * This method sets the request body for an API call
 * @param {String} payload Name of the payload you want to use for the request
 */
    setRequestPayload(payload) {
        var apiRequestBody
        apiRequestBody = fs.readFileSync(
            'test/testData/apiPayLoads/' + payload + '.json'
        );
        apiRequestBody = JSON.parse(apiRequestBody);
        return apiRequestBody;
    }

/**
 * This method sets global parameters that will be used as path parameters (path parameters are set statically in getEndpointURL())
 * @param {Object} dataTable Datatable passed in from cucumber step
 */
    setPathParameters(dataTable) {
        var tData = dataTable.raw();

        tData.forEach(function (tRow) {
            var pathParam = tRow[0];
            userData.setField(pathParam, tRow[1]);
        }, this);
    }

/**
 * This method asserts actual data against expected data
 * @param {String} actualData The actual value returned from an API response
 * @param {String} expectedData The expected value returned from an API response
 * @param {String} performAction The type of assertion we would like to perform
 */
    //generic function action type based assert the exceptedData with actualData
    verifyResponseParam(actualData, exceptedData, performAction) {
        if (performAction.includes('equal')) {
            assert.equal(
                exceptedData,
                actualData,
                'Expected value: ' +
                exceptedData +
                ': and Actual value: ' +
                actualData +
                ' are not equal '
            );
        } else if (performAction.includes('exist')) {
            assert.exists(
                actualData,
                'Actual: ' + actualData + ' is not present'
            );
        } else if (performAction.includes('null')) {
            assert.notExists(
                actualData,
                'Actual: ' + actualData + ' is null or undefined'
            );
        }
        if (performAction == 'notequal') {
            assert.notEqual(
                exceptedData,
                actualData,
                'Expected value: ' +
                exceptedData +
                ': and Actual value: ' +
                actualData +
                ' are not equal'
            );
        }
        if (performAction == 'ok') {
            assert.ok(
                exceptedData > actualData,
                'Expected value: ' +
                exceptedData +
                ': and Actual value: ' +
                actualData +
                ' are not equal'
            );
        }
    }

/**
 * This method is used to set a json path that can be used in verification or manipulation
 * @param {String} jsonpath If it starts with either Request or Response then there should 
 *                          be a predefined config value (see requestApiConfig.js or responseApiConfig.js)
 */
    getJsonPath(jsonpath) {
        var data;
        if (jsonpath.startsWith('Request_')) {
            data = requestApiConfig[jsonpath];
        } else if (jsonpath.startsWith('Response_')) {
            data = responseApiConfig[jsonpath];
        } else if (jsonpath.startsWith('RAS_')) {
            data = responseApiConfig[jsonpath];
        } else {   
                data = jsonpath;
        }
        return data;
    }

/**
 * This method gets the current time stamp
 */
    getCurrentTimeStamp() {
        return new Date(new Date().toUTCString()).toISOString();
    }

/**
 * This updates the existing api request body and returns it as an object
 * @param {String} reqJsonPath The path to the api request body value you want to update
 * @param {String} val The value you want to set
 * @param {String} key The global key value
 * @param {Object} apiRequestBody The request body you want to perform a change against
 */
 requestPayloadChange(reqJsonPath, val, key, apiRequestBody) {
    let changeMade = false
        if (val == 'null') {
            val = null;
            dot.set(reqJsonPath, val, apiRequestBody);
            changeMade = true
        }
        if (val == 'true') {
            val = true;
            dot.set(reqJsonPath, val, apiRequestBody);
            changeMade = true
        }
        if (val == 'false') {
            val = false;
            dot.set(reqJsonPath, val, apiRequestBody);
            changeMade = true
        }
        if (val == '{}') {
            val = {};
            dot.set(reqJsonPath, val, apiRequestBody);
            changeMade = true
        }
        if (val == 'currentTimeStamp') {
            val = getCurrentTimeStamp();
            dot.set(reqJsonPath, val, apiRequestBody);
            changeMade = true
        }
        if (val == 'int') {
            val = 10
            dot.set(reqJsonPath, val, apiRequestBody);
            changeMade = true
        }
        if (val == 'global') {
            val = userData.getField(key);
            dot.set(reqJsonPath, val, apiRequestBody);
            changeMade = true
        }
     if (val == 'remove') {
        dot.remove(reqJsonPath, apiRequestBody);
        changeMade = true
     }
     if (val == 'empty') {
        dot.set(reqJsonPath, '', apiRequestBody);
        changeMade = true
     }
     if (val == 'null') {
        dot.set(reqJsonPath, null, apiRequestBody);
        changeMade = true
     }
     if (val == 'invalidBody') {
        apiRequestBody = JSON.stringify(apiRequestBody) + '})as23},';
        changeMade = true
     }
     if (val == 'emptyBody') {
        apiRequestBody = '';
        changeMade = true
     }
     if (val == 'nullBody') {
        apiRequestBody = null;
        changeMade = true
     }
     if (val == 'emptyJSONBody') {
        apiRequestBody = '{}';
        changeMade = true
    }
    if(changeMade != true){
        dot.set(reqJsonPath, val, apiRequestBody);
    }
    changeMade = false
    return apiRequestBody;
}

/**
 * This updates a global value
 * @param {String} performAction The type of action you want to perform
 * @param {String} globalValue The global value you want to update (globalTestData)
 * @param {String} val The value you want to set
 */
    requestGlobalValueChange(performAction, globalValue, val) {
        if (performAction == 'update') {
            if (val == 'null') {
                val = null;
            }
            if (val == 'true') {
                val == true;
            }
            if (val == 'false') {
                val == false;
            }
            if (val == '') {
                val = '';
            }
            if (val == 'currentTimeStamp') {
                val = getCurrentTimeStamp();
            } 
        } else {
            val = globalValue + val
        }
        return val;
    }

    extractDecodedPayload() {
        let encodedBearerToken = userData.getField("authorization");
        let base64Url = encodedBearerToken.split(".")[1];
        let base64 = base64Url.replace("-", "+").replace("_", "/");
        let decodedPayload = JSON.parse(Buffer.from(base64, "base64").toString("binary"));
        return decodedPayload;
      }
}
export default new apiLibrary();
