const cucumberJson = require("wdio-cucumberjs-json-reporter").default

const attachJsonLog = (data) => {
    let output = null;
    try {
        output = JSON.stringify(data, null, 2)
    } catch (e) {
        console.warn('Error serialising json for debugging ', e)
        output = data.toString()
    }

    cucumberJson.attach(
        output,
        "application/json",
    );
}

const getResponseProperties = ({status, headers, data}) => 
    ({status, headers, data})

export function makeRequest(axios, requestOptions) {
    const {httpsAgent, ...rest} = requestOptions;
    attachJsonLog(rest);
    return axios(requestOptions).then(
        (response) => {
            attachJsonLog(getResponseProperties(response));
            return response;
        },
        (error) => {
            if (error.response) {
                // The request was made and the server responded with a status code
                // that falls out of the range of 2xx
                attachJsonLog(getResponseProperties(error.response));
            } else if (error.request) {
                // The request was made but no response was received
                // `error.request` is an instance  http.ClientRequest
            } else {
                // Something happened in setting up the request that triggered an Error
            }
            // re-throw the error to maintain the axios api context
            throw error
        }
    )
}

export function prettifyBrowserLog(browserLog) {
    return browserLog.map(({level, message, source: loggerName, timestamp}) => {
        const out = {level, timestamp};
        const match = message.match(/^(?<file>[^ ]+) (?<lineInfo>[0-9]+:[0-9]+) "(?<logArgs>.*)"$/)
        if (match) {
            const args = match.groups.logArgs.split('" "')
            if (/^action /.test(args[0])) {
                // If the log message looks like a redux action message, parse out the info we want!
                // file and line info are not interesting for redux log messages

                // this string is double encoded, and our parsing above stripped off the wrapping quotes
                out.action = JSON.parse(JSON.parse(`"${args[1]}"`))
            } else {
                out.file = match.groups.file
                out.lineInfo = match.groups.lineInfo
                out.message = args.join(" ")
            }
        } else {
            out.message = message
        }
        return out
    })
}