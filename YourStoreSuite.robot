*** Settings ***   
Resource    Resources/SuiteSetup.robot
Resource    Pages/HomePage.robot
Resource    Pages/SearchResultsPage.robot
Resource    Pages/CartPage.robot
Resource    Pages/ProductPage.robot        

Suite Setup    Before Suite
Suite Teardown    After Suite
Test Teardown    After Test

*** Test Cases ***
Homepage Test
    [Documentation]    Verifying critical elements on the homepage
    Check Homepage Elements
    
Search Test
    [Documentation]    Verifying product search mechanism //'Camera' is an argument
    [Tags]    Search
    Search Camera
    
Found Page And Cart Test
    [Documentation]    Adding a product to the cart from the search results page
    [Tags]    Search SearchResults    CartPage
    Set Test Variable    ${product}    Smartphone
    Search ${product}
    Add Found ${product} To Cart
    Verify Cart Contents    ${product}

Product Page And Cart Test
    [Documentation]    Adding a product to the cart from the product page
    [Tags]    Search SearchResults    CartPage    ProductPage
    Set Test Variable    ${product}    Tablet
    Search ${product}
    Select Found ${product}
    Verify ${product} Page    
    Add Product To Cart
    Verify Cart Contents    ${product}