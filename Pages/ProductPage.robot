*** Settings ***
Documentation    Product page
Library    SeleniumLibrary
Library    ../Resources/TestDataLibrary.py


*** Variables ***
${PRODUCT_HEADER}    xpath://div[@id='content']//h1
${PRODUCT_PRICE}    xpath://div[@id='content']/div/div[2]/ul[2]//h2
${PRODUCT_TO_CART}    id:button-cart


*** Keywords ***
Verify ${product} Page
    [Documentation]    Verify product page elements
    ${details}    Get Test Product Details    ${product}
    Element Should Contain    ${PRODUCT_HEADER}    ${details}[name]
    Element Should Contain    ${PRODUCT_PRICE}    ${details}[price]

Add Product To Cart
    [Documentation]    Add the product to cart
    Wait Until Element Is Enabled    ${PRODUCT_TO_CART}
    Click Button    ${PRODUCT_TO_CART}
