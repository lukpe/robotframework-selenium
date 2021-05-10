*** Settings ***
Documentation    Setup suite settings
Library    SeleniumLibrary
Library    WebDriverLibrary.py
Variables    SuiteVariables.py


*** Keywords ***
Before Suite
    [Documentation]    Suite setup
    Set Screenshot Directory    Screenshots
    Set Selenium Timeout    ${WAIT}
    Set Selenium Implicit Wait    ${WAIT}
    IF    ${REMOTE} == False
        Browser Local
    ELSE
        Browser Remote
    END
    Maximize Browser Window
  
Browser ${type}
    [Documentation]    Browser type selection
    IF    """${type}""" == """Local"""
        Download Driver    ${BROWSER}
        Open Browser   ${URL}    ${BROWSER}    ${ALIAS}
    ELSE IF  """${type}""" == """Remote"""  
        Open Browser    ${URL}    ${BROWSER}    ${ALIAS}    ${HUB}    ${DESIRED_CAPABILITIES}
    END

After Suite
    [Documentation]    Operations to perform after test suite
    Delete All Cookies
    Close Browser

After Test
    [Documentation]    Operations to perform after every test in suite
    Delete All Cookies
    Go To    ${URL}
