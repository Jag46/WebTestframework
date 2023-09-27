var IPCServicePayloads = (function () {
  const createapplication = () => {
    const body = {
      ipAddress: '192.136.1.13',
      userBrowserLang: 'en-GB',
      userAgent:
        'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36',
      JourneyType: 'Authenticated',
      originalProductID: '7002',
      channel: {
        employeeId: 'Remote',
        businessTxCommChannel: 'INTERNET',
        functionalUnit: '0572',
        sourceSystemID: 'EDB',
        originatingChannel: 'INTERNET',
        distributionChannelTypeCode: 'CODE',
      },
      appId: '21144-HJGL9B',
    };
    return body;
  };

  const checkeligibility = () => {
    const body = {
            'eligibilityDetails': {
              'applicantRevision':'d718f9e8-0d94-4b3a-9462-6ce4634b1aec',
              'applicationRevision': 'ba165139-ba86-4bf9-9dca-e49cbaee2e62',
              'applicantId':'9d95a7e1-4a54-44cd-a17c-e912f2b25925',
              'sortCode': '123456',
              'accountNumber': '12345678',
              'productId': '7002',
              'newProductId': '7006'
            }
    };
    return body;
  };

  const putaccountdata = () => {
    const body = {
      "updateMarketingPreferencesRequest": {
        "isEmailPreferred": true,
        "isMailPreferred": true,
        "isPhonePreferred": true,
        "applicantRevision": "",
        "applicantId": ""
      },
      "updateChequebookRequest": {
        "applicationRevision": "",
        "applicantPreferences": {
          "isChequeBookRequired": true,
          "cardType": "X2X DEBIT"
        }
      }
    }
    return body;
  };

  const updatefatcadetails = () => {
    const body = {
        'isLiableToPayTaxInAnotherCountry': false,
        'applicantId': '9d95a7e1-4a54-44cd-a17c-e912f2b25925',
        'revision': 'd718f9e8-0d94-4b3a-9462-6ce4634b1aec'
    };
    return body;
  };

  const updatetermsandconditionswithod = () => {
    const body = {
        "applicationRevision": "ba165139-ba86-4bf9-9dca-e49cbaee2e62",
        "applicantId": "",
        "appId": "",
        "terms": [
          {
            "productId": "7006",
            "documentType": "Fscs"
          },
          {
            "productId": "7006",
            "documentType": "TnC"
          },
          {
            "productId": "7006",
            "documentType": "RatesAndCharges"
          },
          {
            "productId": "7006",
            "documentType": "OverdraftAgreement"
          },
          {
            "productId": "7006",
            "documentType": "Pcci"
          }
        ]
    };
    return body;
  };

  const updatetermsandconditionswithoutod = () => {
    const body = {
        "applicationRevision": "ba165139-ba86-4bf9-9dca-e49cbaee2e62",
        "applicantId": "",
        "appId": "",
        "terms": [
          {
            "productId": "7006",
            "documentType": "Fscs"
          },
          {
            "productId": "7006",
            "documentType": "TnC"
          },
          {
            "productId": "7006",
            "documentType": "RatesAndCharges"
          }
        ]
    };
    return body;
  };

  const submitswitch = () => {
    const body = {
        "applicationRevision": "",
        "applicantRevision": "",
        "applicantId": "",
        "appId": "",
    };
    return body;
  };
  
  const sendemailbounceback = () => {
    const body = {
        "applicantId": "",
        "appId": ""
    };
    return body;
  };

  return { createapplication: createapplication, checkeligibility:checkeligibility, updatefatcadetails:updatefatcadetails, putaccountdata:putaccountdata, updatetermsandconditionswithod:updatetermsandconditionswithod, updatetermsandconditionswithoutod:updatetermsandconditionswithoutod, submitswitch:submitswitch, sendemailbounceback:sendemailbounceback};
})();
module.exports = IPCServicePayloads;
