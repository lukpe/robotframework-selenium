*** Settings ***
Library    SeleniumLibrary
Library    ../Resources/TestDataLibrary.py      

*** Variables ***
${product_header}    xpath://div[@id='content']//h1
${product_price}    xpath://div[@id='content']/div/div[2]/ul[2]//h2
${product_to_cart}    id:button-cart

*** Keywords ***
Verify ${product} Page
    Log    Verifying product page elements
    ${details}    Get Test Product Details    ${product}
    Element Should Contain    ${product_header}    ${details}[name]
    Element Should Contain    ${product_price}    ${details}[price]
    
Add Product To Cart
    Log    Adding the product to cart
    Click Button    ${product_to_cart}            
    