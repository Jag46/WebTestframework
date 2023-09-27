var globalTestData = function() {
  this.testData = {
    applicationId: "",
    apiResponse: "",
    dbResponse: "",
    dbFormattedResponse: "",
    firstName: "",
    customerData: "",
    testDataPath: ""
  };
  this.setField = function(field, value) {
    this.testData[field] = value;
  };

  this.getField = function(field) {
    return this.testData[field];
  };
  this.deleteField = function(field) {
    delete this.testData[field]
  }
};
module.exports = new globalTestData();
