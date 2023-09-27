var zephyrData = function() {
  this.testData = {
    status: "",
    testCaseMessage: "",
    testCaseName: "",
    firstTestStep: "",
    zephyrTotalStepCount: 0,
    allTestSteps: [],
    testCaseId: 0,
    testProjectId: 0
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
module.exports = new zephyrData();
