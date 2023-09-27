import zephyrRequests from "./zephyrRequests";
import zephyrData from "./zephyrData";
var dot = require('dot-object');
const fs = require("fs-extra");

var stepResultArray = []
var zephyrTest = false

const monthNames = ["January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December"
];
const d = new Date();
const currentMonth = monthNames[d.getMonth()]
var currentYear = new Date().getFullYear()

var folderID 
class zephyrLibrary {

async zephyrBeforeScenario(pickle) {
    let testKey = ''
    let scenarioName = pickle.name
    let sprint = ''
    let story = ''
    let regression = false
    let api = false
    let gui = false
    let cycleExists = false
    let addTestSteps = false
    let forSprint = false
    let forStory = false
    const testStepBody = {
      mode: "OVERWRITE",
      items: []
  }
    const sceanrioTags = ['Automation']
    const testCaseKeyTags = []
    let browserstackCompatibilityType = browser.config.deviceUnderTest === undefined ? '': '-' + browser.config.deviceUnderTest
    let guiRegression = 'IPC-GUI-Regression-' + browser.config.serverUrls.environment + '-' + currentMonth + '-' + currentYear + browserstackCompatibilityType
    let apiRegression = 'IPC-API-Regression-' + browser.config.serverUrls.environment + '-' + currentMonth + '-' + currentYear +  browserstackCompatibilityType
    let storyTag = '@CAO'

    //Check the feature file contains relevant tags, the following are currently considered @sprint, @story, @regression, @api and @gui
    //the only combinations that will allow zephyr calls to continue: Regression+API, Regression+GUI, Story+Sprint
    if(browser.config.sendResultsToZephyr === true) {
      pickle.tags.forEach(tagName => {
        if(tagName.name.toUpperCase().includes('@SPRINT')) {
          sprint = tagName.name.replace('@', '')
          zephyrData.setField('sprintNumber', sprint)
          forSprint = true
          }
        if(tagName.name.toUpperCase().includes(storyTag)) {
          story = tagName.name.replace('@', '')
          zephyrData.setField('storyNumber', story)
          forStory = true
          }
        if(tagName.name.toUpperCase().includes('@REGRESSION')) {
          regression = true
          }
        if(tagName.name.toUpperCase().includes('@API')) {
          api = true
          }
        if(tagName.name.toUpperCase().includes('@GUI')) {
          gui = true
          }
      })

    //Based on the outcome of step one, it will Check the scenario contains a TestCaseKey tag if it does, 
    //it sets zephyr test to true allowing the rest of the zephyr calls to continue and sets the testCaseKey value globally
    if(forSprint === true && forStory === true || regression === true && api === true ||regression === true && gui === true) {
      pickle.tags.forEach(tagName => {
        if(tagName.name.includes('@TestCaseKey=')) {
          //test case key tags are pushed to an array so that scenario outlines can be handled.
          testCaseKeyTags.push(tagName.name.replace('@TestCaseKey=', ''))
          zephyrTest = true
          testKey = tagName.name.replace('@TestCaseKey=', '')
          zephyrData.setField('testCaseKey', testKey.toUpperCase())
        } else {
          sceanrioTags.push(tagName.name)
        }
      })
    }

  let skipGetTestKey = false
  if(zephyrTest === true) {
    if(testCaseKeyTags.length > 1) {
      for (const key of testCaseKeyTags) {
        if(key.includes('CAO')) {
          await zephyrRequests.zephyrGetTestCase(key)
        }
        if(zephyrData.getField('testCaseStatus') === 200) {
          const folderInfo = zephyrData.getField('testFolder')
          if(folderInfo !== undefined && folderInfo !== null){
          folderID = folderInfo.id
          }
          if(zephyrData.getField('testCaseName') == scenarioName) {
            zephyrTest = true
            testKey = key
            skipGetTestKey = true
            zephyrData.setField('testCaseKey', key.toUpperCase())
            break;
          } else {
            zephyrTest = false
          }
        } 
      } 
    }
  }
  //Checks if a test case exists, if it does it then checks if it has test steps 
  //and if they equal the existing steps, if not it updates the existing steps
  if(zephyrTest === true) {
    if(skipGetTestKey == false){
      await zephyrRequests.zephyrGetTestCase(testKey)
      const folderInfo = zephyrData.getField('testFolder')
      if (folderInfo !== undefined && folderInfo !== null){
        folderID = folderInfo.id
      }
    }
      if(zephyrData.getField('testCaseStatus') === 200) {
        await zephyrRequests.zephyrGetTestSteps(testKey)
        //Checks the length of steps on zephyr aginst the length of steps for the scenario, if they are not equal it updates the steps.
        if(zephyrData.getField('zephyrTotalStepCount') != pickle.steps.length) {
          pickle.steps.forEach(stepName => {
            testStepBody.items.push({inline:{description:stepName.text,expectedResult:"The step passes"}})
          })
          await zephyrRequests.zephyrAddTestSteps(zephyrData.getField('testCaseKey'), testStepBody)
          await zephyrRequests.zephyrGetTestSteps(zephyrData.getField('testCaseKey'))
          addTestSteps = false
        }
        //Checks the name of each step on the scenario and compares it against the step name on zephyr 
        //to see if there has been any changes, if there has it then updates the test steps
        let zephyrTestSteps = zephyrData.getField('allTestSteps')
        let i = 0
        zephyrTestSteps.some(zephyrStep => {
          let exitLoop = false
          if(zephyrStep.inline.description.replace(/&quot;/g,'"') != pickle.steps[i].text) {
            exitLoop = true
            addTestSteps = true
          }
          i++
          return exitLoop === true
        })
      
        if(addTestSteps === true) {
          pickle.steps.forEach(stepName => {
            testStepBody.items.push({inline:{description:stepName.text,expectedResult:"The step passes"}})
          })
          await zephyrRequests.zephyrAddTestSteps(zephyrData.getField('testCaseKey'), testStepBody)
          await zephyrRequests.zephyrGetTestSteps(zephyrData.getField('testCaseKey'))
          addTestSteps = false
        }
        //Check the labels against the scenario with whats on zephyr
        let updateTestCase = false
        sceanrioTags.some(tag => {
          let exitLoop = false
          if(!zephyrData.getField('testLabels').includes(tag)){
            exitLoop = true
            updateTestCase = true
          }
          return exitLoop === true
        })
        if(updateTestCase === true){
          await zephyrRequests.zephyrUpdateTestCase(zephyrData.getField('testCaseKey'),zephyrData.getField('testCaseId'),zephyrData.getField('testCaseName'),zephyrData.getField('testProjectId'),sceanrioTags)
        }
      }

      //Does a check against the testCaseName and the scenario name to make sure they match.
      if(zephyrData.getField('testCaseName') !== "" && zephyrData.getField('testCaseName') !== scenarioName) {
        console.error('The scenario '+ scenarioName +' and Zephyr test case name '+zephyrData.getField('testCaseName')+ ' do not match, TestCaseKey is likely incorrect')
        zephyrTest = false
      }

    //If the test case did not exist, then a test case is created based on the scenario name 
    //and we save the newly created testCaseKey. Afterwards we then create the test steps using the new key.
    if(zephyrTest === true) {
      if (zephyrData.getField('testCaseMessage').includes('Test Case') && zephyrData.getField('testCaseMessage').includes('Not Found')) {
        await zephyrRequests.zephyrCreateTestCase(scenarioName, sceanrioTags)
        //Updates the global array testStepBody, which will be used to set the test steps
        pickle.steps.forEach(stepName => {
          testStepBody.items.push({inline:{description:stepName.text,expectedResult:"The step passes"}})
        })
        await zephyrRequests.zephyrAddTestSteps(zephyrData.getField('testCaseKey'), testStepBody)
        await zephyrRequests.zephyrGetTestSteps(zephyrData.getField('testCaseKey'))
        addTestSteps = false
    }
    
    //Checks the result of the zephyrGetTestSteps call from step 3, 
    //if steps were not found it creates them based on the step names of the scenario
    var firstStep = zephyrData.getField('firstTestStep')
    if(firstStep !== "" && firstStep.inline.description === null)  {
      //Updates the global array testStepBody, which will be used to set the test steps
      pickle.steps.forEach(stepName => {
        testStepBody.items.push({inline:{description:stepName.text,expectedResult:"The step passes"}})
      })
      await zephyrRequests.zephyrAddTestSteps(zephyrData.getField('testCaseKey'), testStepBody)
      await zephyrRequests.zephyrGetTestSteps(zephyrData.getField('testCaseKey'))
      addTestSteps = false
    }
        //Check if a value has been set for sprintNumber and storyNumber in zephyr data. This will mean its related to a Jira Story.
        if(zephyrData.getField('sprintNumber') !== undefined && zephyrData.getField('storyNumber') !== undefined) {
          await zephyrRequests.zephyrGetTestCycles()
          //Check the result of the axios zephyrGetTestCycles, if it was successful and there were more than 0 cycles
          if(zephyrData.getField('getTestCyclesStatus') === 200 && zephyrData.getField('getTestCyclesTotal') > 0) {
            //Get the getTestCyclesValues which was stored during the zephyrRequests.zephyrGetTestCycles()
            let cycles = zephyrData.getField('getTestCyclesValues')
            //Loop through each cycle until you find one that matches the if criteria
            cycles.some(cycle => {
              let exitLoop = false
              if(cycle.name.toUpperCase().includes(zephyrData.getField('storyNumber').toUpperCase())) {
                zephyrData.setField('getTestCycleKey', cycle.key.toUpperCase())
                cycleExists = true
                exitLoop = true
              }
              return exitLoop === true
            })
          }
          //If the test cycle did not exist then a test cycle is created based on the jira story number and save the cycle Id
          if(cycleExists === false) {
            await zephyrRequests.zephyrCreateTestCycle(zephyrData.getField('storyNumber') + browserstackCompatibilityType)
            //We call zephyrGetTestCycle with the cycle id from the previous step, so that 
            //we can retrieve the cycle key which can be stored for test execution and issue linkage
            await zephyrRequests.zephyrGetTestCycle(zephyrData.getField('createTestCycleId'))
          }
          let storyId = zephyrData.getField('storyNumber')
          //*note - at this point it's not possible to link via issue
          //await zephyrRequests.zephyrLinkTestCycleIssue(zephyrData.getField('getTestCycleKey'),storyId.replace('cao-', ''))
          //Check if the current cycle has any weblinks if not, link the cycle to the story, via a web link.
          await zephyrRequests.zephyrGetCycleWebLinks(zephyrData.getField('getTestCycleKey'))
          if(zephyrData.getField('cycleWebLinks').length == 0) {
            await zephyrRequests.zephyrLinkTestWebLink(zephyrData.getField('getTestCycleKey'),storyId)
          }
        }
        //If the feature did not contain story/sprint tags then we check if it's for regression + gui.
        // *note - 1129562 = Not Executed on Zephyr Scale Test cycle -------- 1129563 = In Progress on Zephyr Scale Test cycle
        if(regression === true && gui === true) {
          await zephyrRequests.zephyrGetTestCycles()
          if(zephyrData.getField('getTestCyclesStatus') === 200 && zephyrData.getField('getTestCyclesTotal') > 0) {
            //14. Get the getTestCyclesValues which was stored during the zephyrRequests.zephyrGetTestCycles()
            let cycles = zephyrData.getField('getTestCyclesValues')
            //15. Loop through each cycle until you find one that matches the if criteria
            cycles.some(cycle => {
              let exitLoop = false
              if(cycle.name.toUpperCase().includes(guiRegression.toUpperCase()) //&& cycle.status.id ===  1129562 || cycle.status.id ===  1129563
              ) {
                zephyrData.setField('getTestCycleKey', cycle.key.toUpperCase())
                cycleExists = true
                exitLoop = true
              }
              return exitLoop === true
            })
          }
          if(cycleExists === false) {
            await zephyrRequests.zephyrCreateTestCycle(guiRegression)
            await zephyrRequests.zephyrGetTestCycle(zephyrData.getField('createTestCycleId'))
          }
        }
        //If the feature did not contain story/sprint tags then we check if it's for regression + api.
        if(regression === true && api === true) {
          await zephyrRequests.zephyrGetTestCycles()
          if(zephyrData.getField('getTestCyclesStatus') === 200 && zephyrData.getField('getTestCyclesTotal') > 0) {
            //Get the getTestCyclesValues which was stored during the zephyrRequests.zephyrGetTestCycles()
            let cycles = zephyrData.getField('getTestCyclesValues')
            //Loop through each cycle until you find one that matches the if criteria
            cycles.some(cycle => {
              let exitLoop = false
              if(cycle.name.toUpperCase().includes(apiRegression.toUpperCase()) //&& cycle.status.id ===  1129562 || cycle.status.id ===  1129563
              ) {
                zephyrData.setField('getTestCycleKey', cycle.key.toUpperCase())
                cycleExists = true
                exitLoop = true
              }
              return exitLoop === true
            })
          }
          if(cycleExists === false) {
            await zephyrRequests.zephyrCreateTestCycle(apiRegression)
            await zephyrRequests.zephyrGetTestCycle(zephyrData.getField('createTestCycleId'))
          }
        }
      }
      testKey = ''
      sprint = ''
      story = ''
      regression = false
      api = false
      gui = false
      testCaseKeyTags = []
      skipGetTestKey = false
      cycleExists = false
      forSprint = false
      forStory = false
      testStepBody = {
        mode: "OVERWRITE",
        items: []
    }
      sceanrioTags = ['Automation']
    }
  }
}

zephyrAfterStep(step, result, testData) {
  //Pushes the result and name of step to an array for use in Zephyr calls
  if(browser.config.sendResultsToZephyr === true && zephyrTest === true){
      let stepResult = result.passed === true ? 'Pass' : 'Fail';
      let stepObject = {statusName:stepResult,actualResult:step.text + ' - Actual step - resulted in a '+stepResult + " - Test Step Data = " + testData}
      stepResultArray.push(stepObject)
    }
  }

async zephyrAfterScenario(result) {
    if(browser.config.sendResultsToZephyr === true && zephyrTest === true) {
        let currentStepResultLength = stepResultArray.length
        let zephyrTotalStepCount = zephyrData.getField('zephyrTotalStepCount')
        let stepsRemaining = zephyrTotalStepCount - currentStepResultLength
        if(currentStepResultLength != zephyrTotalStepCount) {
          let i
          for(i = 0; i < stepsRemaining; i++) {
            let stepObject = {statusName:"Not Executed",actualResult:""}
            stepResultArray.push(stepObject)
          }
        }
      let scenarioStatus = result.passed === true ? 'Pass' : 'Fail';
      if (zephyrData.getField('testCaseKey') !== undefined && zephyrData.getField('getTestCycleKey') !== undefined) {
        await zephyrRequests.zephyrCreateTestExecution(zephyrData.getField('testCaseKey'),zephyrData.getField('getTestCycleKey'),scenarioStatus,stepResultArray)
      }
    }

    if(browser.config.sendResultsToZephyr === true) {
      await zephyrRequests.zephyrGetTestCase(zephyrData.getField('testCaseKey'))
      if (folderID !== undefined && folderID !== null) {
        await zephyrRequests.zephyrUpdateTestCaseFolder(zephyrData.getField('testCaseKey'),zephyrData.getField('testCaseId'),zephyrData.getField('testCaseName'),zephyrData.getField('testProjectId'),folderID)
      }
    }
    
  
    //Reset the zephyr fields after each scenario
    stepResultArray = []
    zephyrData.setField('testCaseName', '')
    zephyrData.setField('testCaseMessage', '')
    zephyrData.setField('firstTestStep', '')
    zephyrData.setField('zephyrTotalStepCount', 0)
    zephyrData.setField('testProjectId', '')
    zephyrData.setField('allTestSteps', [])
    zephyrData.setField('testFolder', null)
    zephyrData.setField('testCaseKey', '')
    zephyrData.setField('testCaseStatus', '')
    zephyrData.setField('testLabels', '')
    zephyrData.setField('testCaseId', '')
    zephyrTest = false
    folderID = undefined
}

}
export default new zephyrLibrary();
