import axios from 'axios';
import apiLibrary from './apiLibrary';
import { defaultConfig, encodedConfig } from '../testData/apiRequestConfigs/requestConfigs.js';
import qs from 'qs';
import environment from '../support/env.js';
import { request } from 'http';

const fs = require('fs-extra');
const https = require('https');
let userData = require('./globalTestData.js');

var endPointURL = '';
var requestConfig = {};

var apiResponse = {};

var zephyrAuthorization = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI2Mzc2ZDkwMi1mYmI2LTM5NzMtODY4NC1kNjgyM2VkMDYxMjEiLCJjb250ZXh0Ijp7ImJhc2VVcmwiOiJodHRwczpcL1wvbmF0aW9ud2lkZS11ay5hdGxhc3NpYW4ubmV0IiwidXNlciI6eyJhY2NvdW50SWQiOiI1ZTRkMjc2NTRiZWZiZDBjOTZjOTRiYWIifX0sImlzcyI6ImNvbS5rYW5vYWgudGVzdC1tYW5hZ2VyIiwiZXhwIjoxNjQ4NjM1NzUwLCJpYXQiOjE2MTcwOTk3NTB9.4mLPbqiHGkbtXT9qojc_dPAqvyHIgKejKakBwM6Kzv8"

class startJourneyRequests {

    generateJWTRequest(appType, cisNumber) {
        requestConfig = defaultConfig()
        requestConfig.params['apptype'] = appType
        return new Promise(function (resolve, reject) {
            axios
                .get(`${environment.getEnv('stubsBaseURL')}/generateJWTToken/${cisNumber}`, requestConfig)
                .then(function (response) {
                    apiResponse = response;
                    var body = response.data;
                    userData.setField('jwt', body['jwt'])
                    resolve(response);
                })
                .catch(function (error) {
                    apiResponse = error.response;
                    if (apiResponse == null) {
                        userData.setField('apiResponse', apiResponse);
                    } else {
                        userData.setField('apiResponse', apiResponse.data);
                    }
                    resolve();
                });
        });
    }

    generateHandoffUrl(appType, productId, newProductId, accountNumber, environmentName) {
        endPointURL = apiLibrary.getEndpointURL('tokenHandlerExchange');
        requestConfig = encodedConfig()

        if (appType.toLowerCase() === 'olb') {
            requestConfig.params['dctc'] = '210'
        }else if(appType.toLowerCase() === 'ngba') {
            requestConfig.params['dctc'] = '216'
        }else{
            requestConfig.params['dctc'] = '160'
        }
        requestConfig.params['productid'] = productId
        requestConfig.params['newproductid'] = newProductId
        requestConfig.params['environmentName'] = environmentName
        userData.setField('accountNumber', accountNumber);

        var encodedBody = {}
        encodedBody['JwtToken'] = userData.getField('jwt')
        encodedBody['accountNumber'] = accountNumber
        encodedBody = qs.stringify(encodedBody)
        return new Promise(function (resolve, reject) {
            axios
                .post(endPointURL, encodedBody, requestConfig)
                .then(function (response) {
                    apiResponse = response;
                    //userData.setField('fullAPIResponse', apiResponse);
                    let header = response.headers;
                    userData.setField('location', header['location'])
                    resolve(response);
                })
                .catch(function (error) {
                    apiResponse = error.response;
                    if (apiResponse == null) {
                        userData.setField('apiResponse', apiResponse);
                    } else {
                        userData.setField('apiResponse', apiResponse.data);
                    }
                    resolve(error.response);
                })
        });
    }
}
export default new startJourneyRequests();