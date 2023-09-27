'use strict'

browser.addCommand('clearInputValue', function (inputElement) {
    inputElement.setValue(new Array(inputElement.getValue().length).fill("Backspace"))
})

browser.addCommand('waitForUrl', function (url, timeout) {
    browser.waitUntil(() => browser.getUrl() == url, {
        timeout: timeout,
        timeoutMsg: `Expected url to change after ${timeout}ms, current url is ${browser.getUrl()}.`,
        interval: '1000'
    })
})

browser.addCommand('pageLoaded', function (timeout) {

    try {
        return browser.waitUntil(() => {
            let state = browser.execute(function () {
                    return document.readyState;
                })
                return state === 'complete';
            }, timeout, '')
    } catch (error) {
        let message = 'Page not loaded:'

        throw new Error(message)
    }
})

browser.addCommand('waitForPageTitle', function (title, timeout) {
    let actual

    try {
        return browser.waitUntil(() => {
            browser.pause(250)
            actual = browser.getTitle()
            return actual.includes(title)
        }, timeout, '')
    } catch (error) {
        let message = 'Could not wait for required page title:'
            message += `\n\tFull Actual: ${actual}`
            message += `\n\tExpected partial: ${title}`

        throw new Error(message)
    }
})

