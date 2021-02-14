*** Settings ***
Library    SeleniumLibrary
Library    WebDriverLibrary.py
Variables    SuiteVariables.py

*** Keywords ***
Before Suite
    Set Screenshot Directory    Screenshots
    Set Selenium Timeout    ${WAIT}
    Set Selenium Implicit Wait    ${WAIT}
    Run Keyword If    ${REMOTE} == False    Local Browser
    ...    ELSE IF    ${REMOTE} == True    Remote Browser
    Maximize Browser Window
  
Local Browser
    Download Driver    ${BROWSER}
    Open Browser   ${URL}    ${BROWSER}    ${ALIAS}

Remote Browser
    Open Browser    ${URL}    ${BROWSER}    ${ALIAS}    ${HUB}    ${DESIRED_CAPABILITIES}
    
After Suite
    Close Browser
    
After Test
    Delete All Cookies
    Go To    ${URL}