module.exports = {
/* 
* IPC Service response for Create Application
*/
ApplicationCreated: '{"responsePayload":{"appId":"appIdR","applicantRevision":"applicantRevisionR","applicationRevision":"applicationRevisionR","applicantId":"applicantIdR","customerNumber":"customerNoR"},"status":{"code":0,"retry":false,"type":"Success","message":"Success"}}',

/* 
* IPC Service responses for Check Eligibility
*/
//For condition - Is Eligible true
Eligibility_response: '{"responsePayload":null,"status":{"code":202,"retry":false,"type":"Success","message":"Success"}}',

/* 
* IPC Service responses for Get Customer Details
*/
GetCustomerDetails: '{"responsePayload":{"personal":{"name":{"firstName":"Alexandria","lastName":"lastNameR","middleNames":"Maddison Stubber","title":"4","titleText":"Ms"},"dateOfBirth":"1987-11-11T00:00:00Z","addresses":{"address":{"country":"GB","houseNameOrNumber":null,"buildingName":"Sheffield Delivery Office","area":null,"addressLineOne":"Pond Street","addressLineTwo":null,"addressLineThree":null,"townOrCity":"SHEFFIELD","postcode":"S1 1AA","serviceNoRankAndName":null,"unitRegiment":null,"operationName":null,"bfpoNumber":null,"isBfpoAddress":false}},"contactInformation":{"landlineNumber":"01793400003","mobileNumber":"07467735718","emailAddress":"nitin.banota@publicissapient.com"},"marketingPreferences":{"isEmailPreferred":true,"isMailPreferred":true,"isPhonePreferred":true}}},"status":{"code":200,"retry":false,"type":"Success","message":"Success"}}',

/* 
* IPC Service responses for PUT account data endpoint
* 
*/
UpdateFATCADetails: '{"responsePayload":{"applicantRevision":"applicantRevisionR"},"status":{"code":200,"retry":false,"type":"Success","message":"Resource saved/fetched successfully"}}',

/* 
* IPC Service responses for Get Product Data
*/
GetProductData: '{"responsePayload":{"existingProducts":[{"accountFee":0,"accountFeeFrequency":"None","productID":"7002","existingAccount":{"number":"12345678","sortCode":"123456"}}],"offeredProducts":[{"productId":"7006","accountFee":"0.0","accountFeeFrequency":"None","effectiveAnnualInterestRate":"39.9","eStatementSelection":"DoNotOfferChoice_PaperlessByDefault","chequeBookSelection":"OfferChequeBookChoice_DefaultToNotGiven","promotions":[{"isDenied":"false","description":"2% credit interest on credit balances up to £1500 for 12 months (if you credit £1000 each month). No interest charged on arranged overdrafts for 12 months. Eligibility criteria apply to both offers."}]}]},"status":{"code":200,"retry":false,"type":"Success","message":"Success"}}',

/* 
* IPC Service responses for PUT account data endpoint
* https://nbs-banking-services-ipc-int.dev4.edb-a.eu-west-2.notprod.agile.nationwide.co.uk/ipcservice/api/v1/applications/{AppId}/customer/account
*/

PutAccountData: '{"responsePayload":{"applicantRevision":"applicantRevisionR","applicationRevision":"applicationRevisionR"},"status":{"code":20000,"retry":false,"type":"Success","message":"Success"}}',
PutAccountDataNoMarketingPrefs: '{"responsePayload":{"applicantRevision":null,"applicationRevision":"applicationRevisionR"},"status":{"code":20000,"retry":false,"type":"Success","message":"Success"}}',

/* 
* IPC Service responses for PUT terms and conditions endpoint
*/
PutTermsAndConditions: '{"responsePayload":{"applicationRevision":"applicationRevisionR"},"status":{"code":200,"retry":false,"type":"Success","message":"Saved successfully"}}',

/* 
* IPC Service responses for submit switch endpoint
*/
SubmitSwitch: '{"responsePayload":null,"status":{"code":202,"retry":false,"type":"Success","message":"Success"}}',

/* 
* IPC Service responses for SendEmailBounceBack
*/
SendEmailBounceBack: '{"responsePayload":null,"status":{"code":202,"retry":false,"type":"Success","message":"Success"}}',
/* 
* AppStore Service responses 
*/

//GetApplication

//GetApplication
GetApplication_CreateApplication: '{"responsePayload":{"appId":"appIdR","journeyId":"journeyIdR","isJointApp":false,"journeyType":"Authenticated","applicants":[{"id":"applicantIdR","applicantType":"Single","matchStatus":"UNKNOWN","identityCheckMode":"UNKNOWN","impersonationCheckMode":"UNKNOWN","signedTerms":[]}],"errors":[],"commsEvents":[],"lastUpdatedOn":"lastUpdatedTimeR","createdOn":"createdTimeR","caoMessageCodes":[],"statusCode":"Initiated","statusReason":"ApplicationCreated","facilitator":{"userId":"Remote"},"channelInfo":{"originatingChannel":"Web","businessTxCommChannel":".CO.UK","functionalUnit":"0572","distributionChannelTypeCode":"CODE"},"meta":{"browserUserAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36","acceptLanguage":"en-GB","ipAddress":"192.136.1.13"},"applicationState":[{"state":"Started","timestamp":"timestamp1"},{"state":"ApplicantAdded","timestamp":"timestamp2"}],"existingProducts":[],"offeredProducts":[],"revision":"revisionR","nonEditableAttributes":{}},"status":{"code":20000,"retry":false,"type":"Success","message":"Success"}}',

GetApplication_PUTEligibility_true: '{"responsePayload":{"appId":"appIdR","journeyId":"journeyIdR","isJointApp":false,"journeyType":"Authenticated","applicants":[{"id":"applicantIdR","applicantType":"Single","preferences":{"cardType":"X2X DEBIT"},"matchStatus":"UNKNOWN","identityCheckMode":"UNKNOWN","impersonationCheckMode":"UNKNOWN","cisInfo":{"cisCustomerNumber":"customerNoR","isCisCustomerNumVerified":true,"customerIdStatus":"1"},"signedTerms":[],"existingTaxDeclarationStatus":"Y"}],"errors":[],"commsEvents":[],"isValid":true,"lastUpdatedOn":"lastUpdatedTimeR","createdOn":"createdTimeR","caoMessageCodes":[],"statusCode":"InProgress","statusReason":"Applicant eligible for account","facilitator":{"userId":"Remote"},"channelInfo":{"originatingChannel":"Web","sourceSystemId":"EDB","businessTxCommChannel":".CO.UK","functionalUnit":"0572","distributionChannelTypeCode":"CODE"},"meta":{"browserUserAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.125 Safari/537.36","acceptLanguage":"en-GB","ipAddress":"192.136.1.13"},"applicationState":[{"state":"Started","timestamp":"timestamp1"},{"state":"ApplicantAdded","timestamp":"timestamp2"},{"state":"CustomerCreated","timestamp":"timestamp3"}],"isOwnerTraceable":true,"isEligibleForAccount":true,"existingProducts":[{"productId":"7002","agreedOverdraftLimit":100,"isInternalProductChangeCandidate":true,"accountFee":0,"accountFeeFrequency":"None","currentBalance":100,"availableBalance":100,"isJointAccount":false,"existingAccount":{"sortCode":"123456","number":"12345678","accountSetupStatus":"Unknown","accountLocks":[]}}],"offeredProducts":[{"productId":"7006","version":"38","offerType":"Primary","status":"Offered","name":"Flex Direct","isInternalProductSwitch":true,"effectiveAnnualInterestRate":39.9,"accountFee":0,"accountFeeFrequency":"None","chequeBookSelection":"OfferChequeBookChoice_DefaultToNotGiven","eStatementSelection":"DoNotOfferChoice_PaperlessByDefault","availableAccountFacility":"4","promotions":[{"id":"7006","name":"FD No OD Fees 12M, 2% Cred Int 12M","description":"2% credit interest on credit balances up to �1500 for 12 months (if you credit �1000 each month). No interest charged on arranged overdrafts for 12 months. Eligibility criteria apply to both offers.","isDenied":false}]}],"revision":"revisionR","nonEditableAttributes":{}},"status":{"code":20000,"retry":false,"type":"Success","message":"Success"}}',

//GetApplicant
GetApplicant_PUTEligibility_true: '{"responsePayload":{"id":"applicantIdR","isActive":true,"isDeceased":false,"personalInformation":{"name":{"firstName":"Alexandria","lastName":"lastNameR","middleNames":"Maddison Stubber","title":"4","titleText":"Ms"},"isOverEighteenYearsOld":true,"dateOfBirth":"1987-11-11T00:00:00Z","gender":"1"},"addresses":[{"country":"GB","buildingName":"Sheffield Delivery Office","addressLineOne":"Pond Street","townOrCity":"SHEFFIELD","postcode":"postcodeR","isPrimaryAddress":true,"addressLocationId":"1","addressType":"1","isBfpoAddress":false}],"employmentAndIncome":{"employers":[],"incomes":[],"expenses":[],"savings":[]},"marketingPreferences":{"isEmailPreferred":true,"isPhonePreferred":true,"isMailPreferred":true},"contactInformation":{"landlineNumber":"01793400003","mobileNumber":"07467735718","emailAddress":"nitin.banota@publicissapient.com"},"nationalityAndTax":{"isDualNational":false,"taxPaidInCountries":[]},"softLocks":{"customerSoftLock":"customerSoftLockR","emailSoftLock":"013145542600","emailRoleSoftLock":"9481696909001601314554260019901201","addressSoftLock":"012973926600","addressRoleSoftLock":"9481696909000101297392660019901201","mobileSoftLock":"011917701500","mobileRoleSoftLock":"9481696909002001191770150019901201","landLineSoftLock":"011917701500","landLineRoleSoftLock":"9481696909002001191770150019901201"},"createdAt":"createdAtR","lastUpdatedAt":"lastUpdatedAtR","revision":"revisionR"},"status":{"code":200,"retry":false,"type":"Success","message":"Resource saved/fetched successfully"}}',

/* 
* IPC Service Error responses
*/
MissingApplicantId: '{"responsePayload":null,"status":{"code":400,"retry":false,"type":"BusinessException","message":"Missing ApplicantId in request"}}',
InvalidRequest: '{"responsePayload":null,"status":{"code":400,"retry":false,"type":"BusinessException","message":"Invalid request"}}',
MissingxjourneyId: '{"responsePayload":null,"status":{"code":400,"retry":false,"type":"BusinessException","message":"Missing x-journey-id in request"}}',
Unauthorized: '{"responsePayload":null,"status":{"code":401,"retry":false,"type":"BusinessException","message":"Authorization is not available or can not be verified"}}',
InvalidAppId: '{"responsePayload":null,"status":{"code":400,"retry":false,"type":"BusinessException","message":"Valid AppId required in request"}}',
InvalidxjourneyId: '{"responsePayload":null,"status":{"code":400,"retry":false,"type":"BusinessException","message":"Valid x-journey-id required in request"}}',
InvalidApplicantRevision: '{"responsePayload":null,"status":{"code":400,"retry":false,"type":"BusinessException","message":"Valid ApplicantRevision required in request"}}',
InvalidApplicationRevision: '{"responsePayload":null,"status":{"code":400,"retry":false,"type":"BusinessException","message":"Valid ApplicationRevision required in request"}}',
ApplicationUpdateCustomerChequebookDetailsError: '{"responsePayload":null,"status":{"code":500,"retry":false,"type":"BusinessException","message":"Object reference not set to an instance of an object."}}'
}   