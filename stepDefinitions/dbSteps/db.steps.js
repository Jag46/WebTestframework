import { Given, When, Then } from "@cucumber/cucumber";
import axios from "axios";
import environment from "../../support/env.js";
const fs = require("fs-extra");
const https = require("https");
let userData = require("../../utilities/globalTestData.js");
var dbResponse = {};

Given(
  /^I (?:clear|should clear) the test data in database for customer/,
  () => {
    return new Promise(function (resolve, reject) {
      var url = apiConfig.mongoDbApiUrl + userData.getField("customerId");

      let config = {
        responseType: "json",
        httpsAgent: new https.Agent({
          rejectUnauthorized: false
        }),
        withCredentials: true
      };
      axios
        .delete(url, config)
        .then(function (response) {
          resolve(response);
        })
        .catch(function (error) {
          reject(error);
        });
    });
  }
);

When(/^I fetch case data from Mongo DB for application "(.*)"/, function (
  customerNumber
) {
  //customerNumber = userData.getField("CustomerID");
  return new Promise(function (resolve, reject) {
    var MongoDBAPI = environment.getEnv("mongoDBAPI");

    var url = MongoDBAPI + customerNumber;
    console.log("URL : " + url);
    let config = {
      responseType: "json",
      httpsAgent: new https.Agent({
        rejectUnauthorized: false
      }),
      withCredentials: true
    };
    axios
      .get(url, config)
      .then(function (response) {
        dbResponse = response;
        dbResponse = JSON.parse(
          dbResponse.data.replace(/ISODate[(]|[)]/g, "")
        );
        userData.setField("dbResponse", dbResponse);
        /*console.log(
          "\nDB response data JSON formatted---->\n" +
            JSON.stringify(dbResponse)
        );*/
        resolve(response);
      })
      .catch(function (error) {
        console.log("error " + error);
        reject(error);
      });
  });
});

When(
  /^I fetch the customer information from appstore using SAO mirco-service/,
  () => {
    return new Promise(function (resolve, reject) {

      var url = environment.getEnv("mongoDBAPI") + userData.getField("applicationId");

      console.log("url........." + url);

      let config = {
        responseType: "json",
        httpsAgent: new https.Agent({
          rejectUnauthorized: false
        }),
        withCredentials: true
      };
      axios
        .get(url, config)
        .then(function (response) {
          dbResponse = response;
          console.log(JSON.stringify(dbResponse.data));
          userData.setField("dbResponse", dbResponse.data);
          resolve(response);
        })
        .catch(function (error) {
          reject(error);
        });
    });
  }
);