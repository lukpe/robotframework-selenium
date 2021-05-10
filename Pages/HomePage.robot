*** Settings ***
Documentation    Home page
Library    SeleniumLibrary
Library    ../Resources/TestDataLibrary.py           
Resource    SearchResultsPage.robot


*** Variables ***
${PAGE_HEADER}    Your Store
${CART}    id:cart
${VIEW_CART}    View Cart
${NAV_BAR}    class:nav.navbar-nav
${SEARCH_BAR}    name:search
${SEARCH_BUTTON}    class:btn.btn-default.btn-lg
${CATEGORIES}    xpath://ul[@class='nav navbar-nav']/li/a
${CATEGORY_HEADER}    css:h2


*** Keywords ***
Check Homepage Elements
    [Documentation]    Check critical homepage elements
    Page Should Contain    ${PAGE_HEADER}    
    Page Should Contain Element    ${CART}
    Page Should Contain Element    ${NAV_BAR}    
    Page Should Contain Element    ${SEARCH_BAR}

Search ${product}
    [Documentation]    Search for a product
    ...                (The product type argument is optional)
    ${details}    Get Test Product Details    ${product}    
    Input Text    ${SEARCH_BAR}    ${details}[name]
    Click Button    ${SEARCH_BUTTON}
    Wait Until Page Contains    Search - ${details}[name]
    Verify Product Details    ${product}
    
Select Category
    [Documentation]    Select product category
    [Arguments]    ${name}
    @{CATEGORIES}    Get WebElements    ${CATEGORIES}
    ${found}    Set Variable    ${False}
    FOR    ${category}    IN    @{CATEGORIES}
        ${text}    Get Text    ${category}
        ${found}    Evaluate    """${text}""" == """${name}"""
        IF    ${found}
            Click Element    ${category}
        END
        Exit For Loop If    ${found}       
    END
    Should Be True    ${found}
