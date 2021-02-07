*** Settings ***
Library    SeleniumLibrary
Library    ../Resources/TestDataLibrary.py      
Resource    HomePage.robot

*** Variables ***
${cart_name}    xpath://div[@id='checkout-cart']//tbody//td[2]
${cart_price}    xpath://div[@id='checkout-cart']//tbody//td[5]

*** Keywords ***
Verify Cart Contents
    [Arguments]    ${product}
    ${details}    Get Test Product Details    ${product}
    Wait Until Element Contains    ${cart}    ${details}[price]
    Click Element    ${cart}
    Click Link    ${view_cart}
    Element Should Contain    ${cart_name}    ${details}[name]
    Element Should Contain    ${cart_price}    ${details}[price]