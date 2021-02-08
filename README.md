# robotframework-selenium
[Robot Framework]: https://robotframework.org
[SeleniumLibrary]: https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html
[Robot Framework]/[SeleniumLibrary] framework for testing e-commerce page (http://tutorialsninja.com/demo/)

## requirements
* [Python](https://www.python.org/downloads/) (tested on version 3.9.1)
* Web browser ([Google Chrome](https://google.com/chrome) is used by default)

## how to run
1. Install required libraries:</br>
`pip install -r requirements.txt`

2. Run the test suite:</br>
`robot YourStoreSuite.robot`

## configuration
[SuiteVariables.py](/Resources/SuiteVariables.py):
* `URL` -> AUT URL address
* `BROWSER` -> web browser to run tests on (e.g. `chrome`, `gc`, `firefox`, `ff`)
* `HUB` -> [Selenium Grid](https://www.selenium.dev/documentation/en/grid/) hub url
* `DESIRED_CAPABILITIES` -> used in grid tests
* `REMOTE` -> If test should be run on Selenium Grid
* `WAIT` -> Default wait/timeout

Screenshots folder is set up in [SuiteSetup.robot](/Resources/SuiteSetup.robot):</br>
`Set Screenshot Directory    Screenshots`
