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
    Open Browser    ${BROWSER_SETINGS}[0]    ${BROWSER_SETINGS}[1]

Remote Browser
    Open Browser    ${BROWSER_SETINGS}[0]    ${BROWSER_SETINGS}[1]    ${BROWSER_SETINGS}[2]    ${BROWSER_SETINGS}[3]    ${BROWSER_SETINGS}[4]
    
After Suite
    Close Browser
    
After Test
    Delete All Cookies
    Go To    ${URL}