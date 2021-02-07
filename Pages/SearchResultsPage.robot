*** Settings ***
Library    SeleniumLibrary
Library    ../Resources/TestDataLibrary.py       
Library    String    

*** Variables ***
${search_results}    //div[@id='content']//div[contains(@class,'caption')]
${add_to_cart}    xpath://span[text()='Add to Cart']
${succes_alert}    class:alert.alert-success.alert-dismissible
${found_header}    xpath://div[@class='caption']//h4
${found_price}    class:price

*** Keywords ***
Verify Search Results
    Log    Verifying search results
    [Arguments]    ${product}    ${price}
    Page Should Contain    Search - ${product}
    ${elements}    Get WebElements    ${search_results}
    ${found}    Set Variable    ${FALSE}
    FOR    ${element}    IN    @{elements}
        ${text}    Get Text    ${element}
        ${found}    Evaluate    """${product}""" in """${text}"""
        ${found}    Evaluate    """${price}""" in """${text}"""
        Run Keyword If    ${found} == ${TRUE}    Exit For Loop      
    END
    Should Be True    ${found} == ${TRUE}  

Add Found ${product} To Cart
    Log    Adding found product to the shopping cart
    Click Element    ${add_to_cart} 
    ${product_full_name}    Get Text     ${found_header} 
    Wait Until Element Contains    ${succes_alert}    Success: You have added ${product_full_name} to your shopping cart!
    
Select Found ${product}
    Log    Selecting found product
    Click Element    ${found_header}    