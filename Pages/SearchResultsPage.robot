*** Settings ***
Documentation    Search results page
Library    SeleniumLibrary
Library    ../Resources/TestDataLibrary.py
Library    String


*** Variables ***
${SEARCH_RESULTS}    //div[@id='content']//div[contains(@class,'caption')]
${ADD_TO_CART}    xpath://span[text()='Add to Cart']
${SUCCESS_ALERT}    class:alert.alert-success.alert-dismissible
${FOUND_HEADER}    xpath://div[@class='caption']//h4
${FOUND_PRICE}    class:price


*** Keywords ***
Verify Product Details
    [Documentation]    Verify search results
    [Arguments]    ${product}
    ${details}    Get Test Product Details    ${product}
    ${elements}    Get WebElements    ${SEARCH_RESULTS}
    ${found}    Set Variable    ${False}
    FOR    ${element}    IN    @{elements}
        ${text}    Get Text    ${element}
        ${found}    Evaluate    """${details}[name]""" in """${text}"""
        ${found}    Evaluate    """${details}[price]""" in """${text}"""
        IF    ${found} == ${TRUE}
            Exit For Loop
        END
    END
    Should Be True    ${found}

Add Found ${product} To Cart
    [Documentation]    Add found product to the shopping cart
    Click Element    ${ADD_TO_CART}
    ${product_full_name}    Get Text     ${FOUND_HEADER}
    Wait Until Element Contains    ${SUCCESS_ALERT}
    ...    Success: You have added ${product_full_name} to your shopping cart!

Select Found ${product}
    [Documentation]    Select found product
    ${details}    Get Test Product Details    ${product}
    Element Should Contain    ${FOUND_HEADER}    ${details}[name]
    Click Element    ${FOUND_HEADER}
