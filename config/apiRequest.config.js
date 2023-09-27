module.exports = {
  //Domain Request path details
  Request_DomainsavingsIssueId: "savingProductIssue.savingsIssueId",
  Request_Domain_nameTitle: "name.title",
  Request_Domain_firstName: "name.firstName",
  Request_Domain_middleName: "name.middleName",
  Request_Domain_lastName: "name.lastName",
  Request_Domain_gender: "gender",
  Request_Domain_dateOfBirth: "dateOfBirth",

  //IDConfirmation Request
  Request_IDConfirmation_title: "personalInformation.name.title",
  Request_IDConfirmation_firstName: "personalInformation.name.firstName",
  Request_IDConfirmation_middleName: "personalInformation.name.middleName", //optional
  Request_IDConfirmation_lastName: "personalInformation.name.lastName",
  Request_IDConfirmation_gender: "personalInformation.gender",
  Request_IDConfirmation_countryOfBirth: "personalInformation.countryOfBirth",
  Request_IDConfirmation_nationality: "personalInformation.nationality",
  Request_IDConfirmation_dateOfBirth: "personalInformation.dateOfBirth",
  Request_IDConfirmation_niNumber:
    "personalInformation.nationalInsuranceNumber",
  Request_IDConfirmation_hasAdditionalNationality:
    "personalInformation.hasAdditionalNationality",
  Request_IDConfirmation_additionalNationality:
    "personalInformation.additionalNationality",

  Request_IDConfirmation_Address_unitNumber: "currentAddress.unitNumber", //optional
  Request_IDConfirmation_Address_buildingNumber:
    "currentAddress.buildingNumber", //optional
  Request_IDConfirmation_Address_buildingName: "currentAddress.buildingName", //optional
  Request_IDConfirmation_Address_thoroughfareName:
    "currentAddress.thoroughfareName",
  Request_IDConfirmation_Address_dependentThoroughfareName:
    "currentAddress.dependentThoroughfareName", //optional
  Request_IDConfirmation_Address_dependentLocality:
    "currentAddress.dependentLocality", //optional
  Request_IDConfirmation_Address_city: "currentAddress.city",
  Request_IDConfirmation_Address_postcode: "currentAddress.postcode",
  Request_IDConfirmation_Address_country: "currentAddress.country", //optional
  Request_IDConfirmation_Address_moveInMonth: "currentAddress.moveInMonth",
  Request_IDConfirmation_Address_moveInYear: "currentAddress.moveInYear",
  Request_IDConfirmation_Address_pafStatus: "currentAddress.pafStatus",

  //Controller Request path details
  Request_applicationID: "applicationID",
  Request_ControllerProduct: "product",

  //personalInfo
  Request_personalInfo_nameTitle: "title",
  Request_personalInfo_firstName: "firstName",
  Request_personalInfo_middleName: "middleName", //optional
  Request_personalInfo_lastName: "lastName",
  Request_personalInfo_gender: "gender",
  Request_personalInfo_dateOfBirth: "dateOfBirth",
  Request_personalInfo_niNumber: "nationalInsuranceNumber",
  Request_personalInfo_countryOfBirth: "countryOfBirth",
  Request_personalInfo_nationality: "nationality",
  Request_personalInfo_hasAdditionalNationality: "hasAdditionalNationality",
  Request_personalInfo_additionalNationality: "additionalNationality", //optional (AdditionalNationality false)

  //Address
  Request_address_unitNumber: "unitNumber", //optional
  Request_address_buildingNumber: "buildingNumber", //optional
  Request_address_buildingName: "buildingName", //optional
  Request_address_thoroughfareName: "thoroughfareName",
  Request_address_dependentThoroughfareName: "dependentThoroughfareName", //optional
  Request_address_dependentLocality: "dependentLocality", //optional
  Request_address_city: "city",
  Request_address_postcode: "postcode",
  Request_address_country: "country", //optional
  Request_address_moveInMonth: "moveInMonth",
  Request_address_moveInYear: "moveInYear",
  Request_address_pafStatus: "pafStatus",

  //finance
  Request_finance_sourceOfPayForISA: "sourceOfPayForISA",
  Request_finance_savingsAmountOverNext12Months:
    "savingsAmountOverNext12Months",

  //contactdetails
  Request_contactdetails_mobilePhoneNumber: "mobilePhoneNumber",
  Request_contactdetails_landlinePhoneNumber: "landlinePhoneNumber", //optional
  Request_contactdetails_emailAddress: "emailAddress",
  Request_contactdetails_contactByEmail: "contactByEmail",
  Request_contactdetails_contactByLetter: "contactByLetter",
  Request_contactdetails_contactByTelephone: "contactByTelephone",

  //termsandconditions
  Request_termsandconditions_documentType: "documentType",
  Request_termsandconditions_action: "action",
  Request_termsandconditions_version: "version",
  Request_termsandconditions_documentAgreementTimeStamp:
    "documentAgreementTimeStamp",

  //Domain Create Account API
  Request_account_customerNumber: "applicant.customerNumber",
  Request_account_involvedPartySoftLockId: "applicant.involvedPartySoftLockId",
  Request_account_title: "applicant.personalInformation.name.title",
  Request_account_firstName: "applicant.personalInformation.name.firstName",
  Request_account_middleName: "applicant.personalInformation.name.middleName", //optional
  Request_account_lastName: "applicant.personalInformation.name.lastName",
  Request_account_gender: "applicant.personalInformation.gender",
  Request_account_countryOfBirth:"applicant.personalInformation.countryOfBirth",
  Request_account_nationality: "applicant.personalInformation.nationality",
  Request_account_hasAdditionalNationality:"applicant.personalInformation.hasAdditionalNationality", //optional
  Request_account_additionalNationality:"applicant.personalInformation.additionalNationality", //optional
  Request_account_dateOfBirth: "applicant.personalInformation.dateOfBirth",
  Request_account_nationalInsuranceNumber: "applicant.personalInformation.nationalInsuranceNumber",

  Request_account_mobileFullNumber:"applicant.contactInformation.mobilePhoneNumber.fullPhoneNumber",
  Request_account_landlineNumber:"applicant.contactInformation.landlinePhoneNumber.fullPhoneNumber",
  Request_account_emailAddress: "applicant.contactInformation.emailAddress",
  Request_account_contactByEmail:"applicant.contactInformation.marketingPreferences.contactByEmail", //optional
  Request_account_contactByLetter:"applicant.contactInformation.marketingPreferences.contactByLetter", //optional
  Request_account_contactByTelephone:"applicant.contactInformation.marketingPreferences.contactByTelephone", //optional

  Request_account_unitNumber: "applicant.currentAddress.unitNumber", //optional
  Request_account_buildingName: "applicant.currentAddress.buildingName", //optional
  Request_account_thoroughfareName: "applicant.currentAddress.thoroughfareName",
  Request_account_dependentThoroughfareName:"applicant.currentAddress.dependentThoroughfareName", //optional
  Request_account_dependentLocality:"applicant.currentAddress.dependentLocality", //optional
  Request_account_city: "applicant.currentAddress.city",
  Request_account_postcode: "applicant.currentAddress.postcode",
  Request_account_country: "applicant.currentAddress.country", //optional
  Request_account_moveInMonth: "applicant.currentAddress.moveInMonth",
  Request_account_moveInYear: "applicant.currentAddress.moveInYear",
  Request_account_pafStatus: "applicant.currentAddress.pafStatus", //optional

  Request_account_userAgent: "clientSystemInformation.userAgent",
  Request_account_userAcceptLanguage:"clientSystemInformation.userAcceptLanguage",

  //Open Account API
  Request_openaccount_customerId: "customerId",
  Request_openaccount_niNumber: "nationalInsuranceNumber",
  Request_openaccount_productType: "productType",

  //IPC - Check Eligibility API
  Request_eligibility_applicantRevision: "eligibilityDetails.applicantRevision",
  Request_eligibility_applicationRevision: "eligibilityDetails.applicationRevision",
  Request_eligibility_applicantId: "eligibilityDetails.applicantId",
  Request_eligibility_sortCode: "eligibilityDetails.sortCode",
  Request_eligibility_accountNo: "eligibilityDetails.accountNumber",
  Request_eligibility_productId: "eligibilityDetails.productId",
  Request_eligibility_newProductId: "eligibilityDetails.newProductId",
  Request_eligibility_applicantRevision: "eligibilityDetails.applicantRevision",
  Request_eligibility_applicationRevision: "eligibilityDetails.applicationRevision",

  //IPC - Create Application API
  Request_createApplication_appId: "appId",
  Request_createApplication_originalProductId: "originalProductID",

  //IPC - Get AccountList API
  Request_getAccountList_applicationRevision: "applicationRevision",
  Request_getAccountList_originalProductType: "originalProductID",

  //IPC - Update FATCA details
  Request_updateFatcaDetails_applicantRevision: "revision",
  Request_updateFatcaDetails_applicantId: "applicantId",
  Request_updateFatcaDetails_isLiableToPayTaxInAnotherCountry: "isLiableToPayTaxInAnotherCountry",
  Request_updateFatcaDetails_isNonUkResidentForTaxPurposes: "isNonUkResidentForTaxPurposes",
  Request_updateFatcaDetails_isUkResident: "isUkResident",
  Request_updateFatcaDetails_isUsCitizen: "isUsCitizen",
  Request_updateFatcaDetails_tinNumber1: "taxPaidInCountries[0].tinNumber",
  Request_updateFatcaDetails_country1: "taxPaidInCountries[0].country",
  Request_updateFatcaDetails_tinNumber2: "taxPaidInCountries[1].tinNumber",
  Request_updateFatcaDetails_country2: "taxPaidInCountries[1].country",
  Request_updateFatcaDetails_tinNumber3: "taxPaidInCountries[2].tinNumber",
  Request_updateFatcaDetails_country3: "taxPaidInCountries[2].country",

//IPC - General
Request_applicationRevision: "applicationRevision",
Request_applicantRevision: "applicantRevision",
Request_applicantId: "applicantId",
Request_appId: "appId"

};
