const https = require("https");
const axios = require('axios')

const defaultConfig = function gentemplate(){
  const config = {
    headers: {
      "Content-Type": "application/json",
      "ACCEPT": "*/*",
      "Accept-Language": "en-GB,en-IN;q=0.9,en-US;q=0.8,en;q=0.7",
    },
    responseType: "json",
    httpsAgent: new https.Agent({
      rejectUnauthorized: false
    }),
    withCredentials: true,
    params: {}
  }
  return config
} 

const encodedConfig = function gentemplate() {
  const config = {
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      "ACCEPT": "*/*",
      "Accept-Language": "en-GB,en-IN;q=0.9,en-US;q=0.8,en;q=0.7",
    },
    responseType: "json",
    httpsAgent: new https.Agent({
      rejectUnauthorized: false
    }),
    withCredentials: true,
    maxRedirects: 0,
    validateStatus: function (status) {
      return status == 302;
    },
    params: {}
  }
  return config
} 

export {defaultConfig,encodedConfig}
