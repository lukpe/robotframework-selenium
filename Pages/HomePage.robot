*** Settings ***
Library    SeleniumLibrary
Library    ../Resources/TestDataLibrary.py           
Resource    SearchResultsPage.robot


*** Variables ***
${page_header}    Your Store
${cart}    id:cart
${view_cart}    View Cart
${nav_bar}    class:nav.navbar-nav
${search_bar}    name:search
${search_button}    class:btn.btn-default.btn-lg
${categories}    xpath://ul[@class='nav navbar-nav']/li/a
${category_header}    css:h2

*** Keywords ***
Check Homepage Elements
    Log    Checking critical homepage elements
    Page Should Contain    ${page_header}    
    Page Should Contain Element    ${cart}
    Page Should Contain Element    ${nav_bar}    
    Page Should Contain Element    ${search_bar}

Search ${product}
    Log    Searching for a product
    [Documentation]    The product type argument is optional
    ${details}    Get Test Product Details    ${product}    
    Input Text    ${search_bar}    ${details}[name]
    Click Button    ${search_button}
    Wait Until Page Contains    Search - ${details}[name]
    Verify Product Details    ${product}
    
Select Category
    [Arguments]    ${name}
    @{categories}    Get WebElements    ${categories}
    ${found}    Set Variable    ${False}
    FOR    ${category}    IN    @{categories}
        ${text}    Get Text    ${category}
        ${found}    Evaluate    """${text}""" == """${name}"""    
        Run Keyword If    ${found}    Click Element    ${category}
        Exit For Loop If    ${found}       
    END
    Should Be True    ${found}
    
