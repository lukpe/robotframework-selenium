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
    [Documentation]    Verify critical elements on the homepage
    Check Homepage Elements
    
Search Test
    [Documentation]    Verify product search mechanism
    [Tags]    Search
    Search Camera1
    
Found Page And Cart Test
    [Documentation]    Add a product to the cart from the search results page
    [Tags]    Search SearchResults    CartPage
    Set Test Variable    ${product}    Smartphone1
    Search ${product}
    Add Found ${product} To Cart
    Verify Cart Contents    ${product}

Product Page And Cart Test
    [Documentation]    Add a product to the cart from the product page
    [Tags]    Search SearchResults    ProductPage    CartPage 
    Set Test Variable    ${product}    Tablet1
    Search ${product}
    Select Found ${product}
    Verify ${product} Page    
    Add Product To Cart
    Verify Cart Contents    ${product}
    
Product Category Test
    [Documentation]    Check if appropriate products ale listed under a category
    [Tags]    Categories
    Set Test Variable    ${category}    Phones & PDAs
    Select Category    ${category}
    Verify Product Details    Smartphone1
    Verify Product Details    Smartphone2
    Verify Product Details    Smartphone3
    
Guest Purchase Test
    [Documentation]    Check if a product can be purchased using guest account
    [Tags]    Search SearchResults    ProductPage    CartPage    GuestAccount    Purchase
    Set Test Variable    ${product}    Monitor1
    Search ${product}
    Select Found ${product}
    Add Product To Cart
    Verify Cart Contents    ${product}
    Proceed Guest Purchase    ${product}
    
    
    